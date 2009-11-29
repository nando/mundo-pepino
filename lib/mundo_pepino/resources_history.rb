module MundoPepino
  module ResourcesHistory
    module MentionedResource
      def mr_instance
        self.is_a?(Array) ? self.first : self
      end
      
      def mr_new_record?
        self.mr_instance.new_record?
      end
      
      def mr_model
        self.mr_instance.class
      end
      
      def mr_singular
        self.mr_model.name.underscore
      end
      
      def mr_plural
        self.mr_model.table_name
      end
    end

    # options: :force_creation 
    def add_resource(model, attribs=[], options = {})
      attributes = if attribs.is_a?(Hash)
        [ attribs ] 
      else
        attribs
      end
      res = if attributes.size == 1
        find_or_create(model, attributes.first, options)
      else
        attributes.map do |hash| 
          find_or_create(model, hash, options) 
        end
      end
      pile_up res
    end
  
    def add_resource_from_database(raw_model, name)
      model = raw_model.to_unquoted.to_model
      field = field_for(model)
      if resource = model.send("find_by_#{field}", name)
        pile_up resource
      else
        raise NotFoundInDatabase.new(model, name)
      end
    end

    def pile_up(mentioned)
      @resources ||= []
      if mentioned != last_mentioned
        mentioned.class.send :include, MentionedResource
        @resources.unshift mentioned
      end
      mentioned
    end
  
    def last_mentioned
      @resources && @resources.first
    end
  
    def last_mentioned_url 
      if mentioned = last_mentioned
        if mentioned.mr_new_record?
          eval("#{mentioned.mr_plural}_path")
        else
          eval("#{mentioned.mr_singular}_path(mentioned.mr_instance)")
        end
      else
        raise WithoutResources
      end
    end
  
    def last_mentioned_of(raw_model, with_name = nil)
      if model = raw_model.to_model
        resource = if with_name
          if mentioned = detect_first(resources_flatten, [model, with_name])
            mentioned
          else
            begin
              add_resource_from_database(raw_model, with_name)
            rescue
              raise NotFoundInHistoryNorDatabase.new(model.name, with_name)
            end
          end
        elsif(last_mentioned.mr_model == model)
          last_mentioned
        else
          if group = recursive_group_search(model, @resources[1..-1])
            group
          else
            detect_first resources_flatten, model
          end
        end
        resource || raise(ResourceNotFound.new("model:#{model.name}, name:#{with_name||'nil'}"))
      else
        raise ModelNotMapped.new(raw_model)
      end
    end
  
    def last_mentioned_called(name)
      detect_first resources_flatten, name
    end
    
    def last_mentioned_resources(model, name)
      mentioned = last_mentioned_of(model.to_unquoted, name)
      if mentioned.is_a?(Array)
        mentioned.each {|m| yield m}
      else
        yield mentioned
      end
      pile_up mentioned
    end
  
    def recursive_group_search(model, resources)
      if lm = resources.shift
        if(lm.is_a?(Array) and (lm.mr_model == model))
          lm
        else
          recursive_group_search(model, resources)
        end
      end
    end
  
    def detect_first(arr, value, method = nil)
      if value.is_a? String
        method ||= :name
        arr.detect { |r| r.respond_to?(method) && (r.send(method) =~ /#{value}/i) }
      elsif value.is_a? Class
        method ||= :is_a?
        arr.detect { |r| r.respond_to?(method) && r.send(method, value) }
      elsif value.is_a? Array
        model, val = value # [ class, value ]
        name_field = field_for(model)
        arr.detect do |r| 
          r.respond_to?(:is_a?) && r.is_a?(model) && r.send(name_field) =~ /#{val}/i
        end
      else
        method ||= :id
        arr.detect { |r| r.respond_to?(method) && r.send(method) == value }
      end
    end
  
    def resources_array_field_and_values(mentioned, campo, valor)
      resources, valores = if mentioned.is_a?(Array)
        valores = valor.split(/ ?, | y /)
        if valores.size == mentioned.size
          [mentioned, valores]
        else
          [mentioned, [valor] * mentioned.size]
        end
      else
        [[mentioned], [valor]]
      end
      field, values = if (child_model = campo.to_model)
        child_name_field = field_for(child_model)
        values = add_resource(child_model,
          valores.map { |val| { child_name_field => val } })
        values = [ values ] unless values.is_a?(Array)
        [field_for(mentioned.mr_model, campo) || child_model.name.underscore, values]
      else
        [field_for(mentioned.mr_model, campo), valores]
      end 
      [resources, field, values]
    end

    def resources_flatten
      (@resources || []).flatten
    end
  
    def method_missing(method, *args, &block)
      if (method.to_s =~ /^last_mentioned_(.+)$/)
        if mentioned = last_mentioned
          last_mentioned.send("mr_#{$1}") 
        else
          nil
        end
      else
        super
      end
    end
  
  end
end
