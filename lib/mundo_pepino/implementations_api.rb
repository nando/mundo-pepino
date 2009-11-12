module MundoPepino
  module ImplementationsApi
    def real_value_for(v)
      (v.is_a?(String) ? v.to_real_value : v )
    end

    def names_for_simple_creation(model, number, name_or_names, options = {})
      base_hash = base_hash_for(options)
      if name_or_names
        field = field_for(model)
        names = name_or_names.split(/ ?, | y /)
        if names.size == number
          names.map { |name| base_hash.dup.merge(field => name) }
        else
          [base_hash.dup.merge(field => name_or_names)] * number
        end
      else
        [base_hash] * number
      end
    end
  
    def field_for(model=nil, field = nil)
      model_name = "#{model && model.name+'::'}"
      if field
        "#{model_name}#{field}".to_field || field.to_field
      else
        # The use of "nombre" the name field mapping is deprecated
        "#{model_name}nombre".to_field || 'nombre'.to_field || 
        # "Model::name" or "name" (for a global mapping) is the right use.
        "#{model_name}name".to_field || 'name'.to_field || :name
      end
    end

    def shouldify(should_or_not)
      affirmative = 'debo|debo ver|veo|deber[ií]a|deber[íi]a ver|leo|debo leer|deber[ií]a leer'
      should_or_not =~ /^(#{affirmative})$/i ? :should : :should_not
    end
  
    def not_shouldify(should_or_not)
      shouldify(should_or_not) == :should ? :should_not : :should
    end
  
    def relative_page(pagina)
      if pagina =~ /la siguiente p[aá]gina|la p[aá]gina anterior/i
        head, current, tail = if last_visited =~ /(.+page=)(\d+)(.*)/
          [$1, $2.to_i, $3]
        else
          [last_visited + '?page=', 1, '']
        end
        (pagina =~ /siguiente/ ? current += 1 : current -= 1)
        head + current.to_s + tail
      else
        nil
      end
    end
  
    # Cucumber::Model::Table's hashes traduciendo nombres de campo
    def translated_hashes(step_table, options = {})
      base_hash = base_hash_for(options)
      header = step_table[0].map do |campo| 
        field_for(options[:model], campo) || campo 
      end
      step_table[1..-1].map do |row|
        h = base_hash.dup
        row.each_with_index do |v,n|
          key = header[n]
          h[key] = v
        end
        h
      end
    end
  
    def base_hash_for(options) 
      if options[:parent]
        # polymorphic associations
        if options[:polymorphic_as]
          { "#{options[:polymorphic_as]}_id" => options[:parent].id,
            "#{options[:polymorphic_as]}_type" => options[:parent].class.name }
        else 
          field_prefix = options[:parent].class.name.underscore
          if options[:through]
            {:through => {"model" => eval(options[:through].to_s.classify),
                          "attributes" => {"#{field_prefix}_id"  => options[:parent].id}}}
          else
            { "#{field_prefix}_id" => options[:parent].id }
          end
        end
      else
        {}
      end
    end
  
    def campo_to_field(campo, model = nil)
      unless campo.nil? 
        if field = field_for(model, campo.to_unquoted)
          field
        else
          raise MundoPepino::FieldNotMapped.new(campo) 
        end
      end
    end
    
    def last_mentioned_should_have_n_children(child, numero)
      if child_model = child.to_model
        (last_mentioned.send child_model.table_name).size.should == numero.to_number
      else
        raise ModelNotMapped.new(child)
      end
    end
    
    def last_mentioned_should_have_value(campo, valor)
      res = last_mentioned
      if child_model = campo.to_model
        child = child_model.send "find_by_#{field_for(child_model)}", valor
        child_field = campo.to_field || child_model.name.underscore
        (res.send child_field).should == child
      elsif field = field_for(res.class, campo)
        (res.send field).to_s.should == valor.to_s
      else
        raise FieldNotMapped.new(campo)
      end
    end
    
    def last_mentioned_should_have_child(child, name)
      if child_model = child.to_model
        child = child_model.send "find_by_#{field_for(child_model)}", name
        (last_mentioned.send child_model.table_name).detect do |c|
          c.id == child.id 
        end.should_not be_nil
      else
        raise ModelNotMapped.new(child)
      end
    end
    
    def find_field_and_do_with_webrat(action, campo, options = nil)
      do_with_webrat action, campo.to_unquoted.to_translated, options # a pelo (localización vía labels)
    rescue Webrat::NotFoundError
      field = campo_to_field(campo, last_mentioned_model)
      begin 
        do_with_webrat action, field, options # campo traducido tal cual...
      rescue Webrat::NotFoundError
        if singular = last_mentioned_singular # traducido y con el modelo por delante
          do_with_webrat action, singular + '_' + field.to_s, options # p.e.: user_name
        else
          raise
        end
      end
    end
  
    def do_with_webrat(action, field, options)
      if options
        if options[:path] and options[:content_type]
          self.send action, field, options[:path], options[:content_type]
        else
          self.send action, field, options
        end
      else
        self.send action, field
      end
    end
  
    def parent_options(parent, child)
     options = {:parent => parent}
      # polymorphic associations
      if reflections = parent.class.reflect_on_association(child.table_name.to_sym)
        if reflections.options[:as]
          options.merge!({:polymorphic_as => reflections.options[:as]})
        elsif reflections.options[:through]
          options.merge!({:through => reflections.options[:through]})
        end
      end
      options
    end

    def resource_index_or_mapped_page(the_page_of, raw_model)
      unquoted_model = raw_model.to_unquoted
      if model = unquoted_model.to_model
        pile_up model.new
        eval("#{model.table_name}_path")
      elsif url = "#{the_page_of}#{raw_model}".to_url
        url
      else
        raise MundoPepino::ModelNotMapped.new(unquoted_model)
      end
    end

    def nested_attribute_field_id(nested_field, nested_model, nested_name, parent_model=nil)
      unquoted_model = nested_model.to_unquoted
      if model = unquoted_model.to_model
        if res = model.send("find_by_#{field_for(model)}", nested_name)
          parent = if parent_model
            parent_model.name.underscore
          else
            '[a-z][a-z_]*[a-z]'
          end
          prefix = "#{parent}_#{model.name.pluralize.underscore}_attributes"
          if seq = sequence_number_for_nested_resource(res, prefix)
            "#{prefix}_#{seq}_#{nested_field.to_field}"
          else
            nil
          end
        else
          raise MundoPepino::ResourceNotFound.new("No '#{unquoted_model}' called '#{nested_name}'")
        end
      else
        raise MundoPepino::ModelNotMapped.new(unquoted_model)
      end
    end

    def sequence_number_for_nested_resource(resource, id_prefix)
      Nokogiri::HTML.parse(response.body).xpath(
        "//input[@type='hidden' and @value=#{resource.id}]"
      ).each do |input|
        if input.attributes['id'].to_s =~ /#{id_prefix}_([0-9]+)_id/
          return $1
        end
      end
    end
  end  
end

