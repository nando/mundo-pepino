require 'rubygems'
require 'nokogiri'

module MundoPepino
  module ImplementationsApi
    MAX_NESTED_RESOURCES = 30 # TODO: move this to MP.configure
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
        "#{model_name}name".to_field || 'name'.to_field ||
        # The use of "nombre" the name field mapping is deprecated
        "#{model_name}nombre".to_field || 'nombre'.to_field || :name
      end
    end

    def hasify(should_or_not)
      shouldify(should_or_not) == :should ? :have : :have_no
    end

    def not_hasify(should_or_not)
      hasify(should_or_not) == :have ? :have_no : :have
    end

    def shouldify(should_or_not)
      should_or_not =~ /^(#{MundoPepino::Matchers::Bites._should_})$/i ? :should : :should_not
    end

    def not_shouldify(should_or_not)
      shouldify(should_or_not) == :should ? :should_not : :should
    end

    # Cucumber::Model::Table's hashes traduciendo nombres de campo
    def translated_hashes(step_table, options = {})
      base_hash = base_hash_for(options)
      header = step_table[0].map do |raw_field|
        field_for(options[:model], raw_field) || raw_field
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
          field_prefix = options[:parent_field] || options[:parent].class.name.underscore
          if options[:through]
            {:through => {"model" => eval(options[:through].to_s.classify),
                          "attributes" => {"#{field_prefix}_id"  => options[:parent].id}}}
          else
            {"#{field_prefix}_id" => options[:parent].id}
          end
        end
      else
        {}
      end
    end

    def convert_to_model(raw_model)
      raw_model.to_unquoted.to_model || raise(ModelNotMapped.new(raw_model))
    end

    def convert_to_field(raw_field, model = nil)
      unless raw_field.nil?
        if field = field_for(model, raw_field.to_unquoted.to_translated)
          field
        else
          raise MundoPepino::FieldNotMapped.new(raw_field)
        end
      end
    end

    def last_mentioned_children(field_raw)
      if child_model = field_raw.to_model
        parent_model = last_mentioned.mr_model
        children = last_mentioned.send field_for(parent_model, field_raw) ||
                            field_for(parent_model, child_model.table_name) ||
                            child_model.table_name
        children.is_a?(Array) ? children : [children] #for has_one_associations
      else
        raise ModelNotMapped.new(field_raw)
      end
    end

    def last_mentioned_should_have_n_children(field, number)
      last_mentioned_children(field).size.should == number.to_number
    end

    def last_mentioned_should_have_value(raw_field, valor)
      res = last_mentioned
      if child_model = raw_field.to_model
        child = child_model.send "find_by_#{field_for(child_model)}", valor
        child_field = field_for(res.mr_model, raw_field) || child_model.name.underscore
        (res.send child_field).should == child
      elsif field = field_for(res.class, raw_field)
        (res.send field).to_s.should == valor.to_s
      else
        raise MundoPepino::FieldNotMapped.new(raw_field)
      end
    end

    def last_mentioned_should_have_child(field_raw, name)
      children = last_mentioned_children(field_raw)
      child = if children.any?
        model = children.first.class
        model.send("find_by_#{field_for(model)}", name)
      end
      children.detect {|c| c.id == child.id}.should_not be_nil
    end

    def find_field_and_do(action, raw_field, options = nil)
      if defined?(Webrat)
        # Webrat
        find_field_and_do_with_webrat(action, raw_field, options)
      else
        # Capybara
        find_field_and_do_with_capybara(action, raw_field, options)
      end
    end

    def find_field_and_do_with_capybara(action, raw_field, options = nil)
      do_with_capybara action, raw_field.to_unquoted.to_translated, options # a pelo (localización vía labels)
    rescue Capybara::ElementNotFound
      field = convert_to_field(raw_field, last_mentioned_model)
      begin
        do_with_capybara action, field.to_s, options # campo traducido tal cual...
      rescue Capybara::ElementNotFound
        #TODO cucumber -p capybara_es_ES features/es_ES/tenemos-en-bbdd-registros.feature:50 # Scenario: dos campos has_many del mismo modelo
        # se busca un campo "name" tenemos "for=session_name" y el texto del label es 'Name' capybara es casesensitive
        raise $! if field.to_s.capitalize == field.to_s
        do_with_capybara action, field.to_s.capitalize, options
      end
    end

    def do_with_capybara(action, field, options)
      if options
        if options[:path] # and options[:content_type]
          self.send action, field, options[:path]#, options[:content_type]
        else
          self.send action, field, options
        end
      else
        self.send action, field
      end
    end

    def find_field_and_do_with_webrat(action, raw_field, options = nil)
      do_with_webrat action, raw_field.to_unquoted.to_translated, options # a pelo (localización vía labels)
    rescue Webrat::NotFoundError
      field = convert_to_field(raw_field, last_mentioned_model)
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

    def parent_options(parent, child_model, child_field)
      options = {:parent => parent}
      if child_field and
         parent_field = "#{child_model.name}::#{child_field}".to_field
        options[:parent_field] = parent_field
      elsif reflections = parent.class.reflect_on_association(child_model.table_name.to_sym)
        # many to many associations
        if reflections.options[:as]
          options[:polymorphic_as] = reflections.options[:as]
        elsif reflections.options[:through]
          options[:through] = reflections.options[:through]
        end
      end
      options
    end

    def resource_index_or_mapped_page(the_page_of, raw_model)
      unquoted_model = raw_model.to_unquoted
      if model = unquoted_model.to_model
        pile_up model.new
        MundoPepino.world.send "#{model.table_name}_path"
      elsif url = "#{the_page_of} #{raw_model}".to_page
        url
      else
        raise MundoPepino::ModelNotMapped.new(unquoted_model)
      end
    end

    def nested_field_id(parent_resource, nested_model, nested_field, nested_name)
      unquoted_model = nested_model.to_unquoted
      if model = unquoted_model.to_model
        field = field_for(parent_resource.mr_model, nested_field)
        if nested_name.nil?
          new_nested_field_id(parent_resource, model, field)
        else
          # Nested attrib. change
          if res = model.send("find_by_#{field_for(model)}", nested_name)
            if field_prefix = nested_field_id_prefix(parent_resource, res)
              "#{field_prefix}#{field}"
            else
              # TODO: raise NestedAttributeNotFound
            end
          else
            raise MundoPepino::ResourceNotFound.new("No '#{unquoted_model}' called '#{nested_name}'")
          end
        end
      else
        raise MundoPepino::ModelNotMapped.new(unquoted_model)
      end
    end

    def nested_field_id_prefix(parent_resource, resource)
      preprefix = nested_field_prefix_prefix(parent_resource.mr_model, resource.class)
      # We can use response with capybara due to capextensions
      Nokogiri::HTML.parse(response.body).xpath(
        "//input[@type='hidden' and @value=#{resource.id}]"
      ).each do |input|
        return "#{preprefix}_#{$1}_" if input.attributes['id'].to_s =~ /#{preprefix}_([0-9]+)_id/
      end
    end

    def new_nested_field_id(parent_resource, model, field)
      preprefix = nested_field_prefix_prefix(parent_resource.mr_model, model)
      (0..MAX_NESTED_RESOURCES).each do |index|
        # We can use response with capybara due to capextensions
        if Nokogiri::HTML.parse(response.body).css("##{preprefix}_#{index}_id").empty?
          return "#{preprefix}_#{index}_#{field}"
        end
      end
      # TODO: raise too many nested resources
    end

    def nested_field_prefix_prefix(parent_model, child_model)
      "#{parent_model.name.underscore}_#{child_model.name.pluralize.underscore}_attributes"
    end

    # Used with capybara
    def contain_text_or_regexp(text_or_regexp)
      # TODO not support regexp -> based on cucumber web_steps.rb
      text_or_regexp = text_or_regexp.to_unquoted.to_translated
      if text_or_regexp.is_a?(String)
        "content('#{text_or_regexp}')"
      else
        "xpath('//*', :text => /#{text_or_regexp}/)"
      end
    end

    def should_or_not_contain_text(*args)
      params = args.last.is_a?(Hash) ? args.pop : {}
      content = args.empty? ? nil : args.first

      # We can use response and contain with capybara due to capextensions
      if defined?(Capybara)
        #"response.should have(?:_no)?_content(params[:text])"
        #"response.should have(?:_no)?_xpath(, :text => params[:text])"
        response.should eval("#{hasify(params[:should])}_#{contain_text_or_regexp(params[:text])}")
      else
        if content
          content.send(
                  shouldify(params[:should]),
                  contain(params[:text].to_unquoted.to_translated.to_regexp))
        else
          response.send(
                shouldify(params[:should]),
                contain(params[:text].to_unquoted.to_translated.to_regexp))
        end
      end
    end
  end
end


