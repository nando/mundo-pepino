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

    class ResourceNotFound < RuntimeError
      def initialize(resource_info=nil)
        @resource_info = resource_info && " (#{resource_info})"
      end
      def message
        "Resource not found#{@resource_info}"
      end
    end
  
    class WithoutResources < ResourceNotFound
      def initialize
        super 'there is no resources'
      end
    end

    class NotFoundInDatabase
      def initialize(model, value='')
        super "#{model} #{value} not found in database"
      end
    end

    class NotMapped < RuntimeError
      def initialize(type, string)
        @type = type
        @string = string
      end
      def message
        "#{@type} not mapped '#{@string}'"
      end
    end

    class ModelNotMapped < NotMapped
      def initialize(string)
        super('Model', string)
      end
    end

    class FieldNotMapped < NotMapped
      def initialize(string)
        super('Field', string)
      end
    end

    class CrudActionNotMapped < NotMapped
      def initialize(string)
        super('CRUD Action', string)
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
  
    def add_resource_from_database(modelo, name)
      model = modelo.to_unquoted.to_model
      field = field_for(model)
      if resource = model.send("find_by_#{field}", name)
        pile_up resource
      else
        NotFoundInDatabase.new(model, name)
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
  
    def last_mentioned_of(modelo, with_name = nil)
      if model = modelo.to_model
        resource = if with_name
          detect_first @resources.flatten, [model, with_name]
        elsif(last_mentioned.mr_model == model)
          last_mentioned
        else
          if group = recursive_group_search(model, @resources[1..-1])
            group
          else
            detect_first @resources.flatten, model
          end
        end
        resource || raise(ResourceNotFound.new("model:#{model.name}, name:#{with_name||'nil'}"))
      else
        raise ModelNotMapped.new(modelo)
      end
    end
  
    def last_mentioned_called(name)
      detect_first @resources.flatten, name
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
          [mentioned, [ valor ] * mentioned.size]
        end
      else
        [[ mentioned ], [ valor ]]
      end
      field, values = if (child_model = campo.to_model)
        child_name_field = field_for(mentioned.mr_model)
        values = add_resource(child_model,
          valores.map { |val| { child_name_field => val } })
        values = [ values ] unless values.is_a?(Array)
        [ campo.to_field || child_model.name.underscore, values ]
      else
        [ field_for(mentioned.mr_model, campo), valores ]
      end 
      [resources, field, values]
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
