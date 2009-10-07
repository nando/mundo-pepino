$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'cucumber/rails/world'
require 'mundo_pepino/resources_history'
require 'mundo_pepino/visits_history'
require 'mundo_pepino/version'

require 'string-mapper'

module MundoPepino

  include ResourcesHistory
  include VisitsHistory
	
  def real_value_for(v)
    (v.is_a?(String) ? v.to_real_value : v )
  end

  def parsed_attributes(raw_attributes)
    attributes = {}
    raw_attributes.each do |k, v|
      if k =~ /^(.+)_id$/
        if polymorph = raw_attributes.delete($1 + '_type')
          attributes[$1.to_sym] = polymorph.constantize.find(v.to_i)
        else
          attributes[$1.to_sym] = ($1.to_relation_model || $1.camelize.constantize).find(v.to_i)
        end
      else
        attributes[k] = real_value_for(v)
      end
    end
    attributes
  end

  def create(model, raw_attributes = {})
    through = raw_attributes.delete(:through)
    attributes = parsed_attributes(raw_attributes)
    obj = if defined?(FixtureReplacement)
      self.send "create_#{model.name.underscore}", attributes
    elsif defined?(Machinist)
      model.make attributes
    elsif defined?(Factory)
      Factory(model.name.underscore.to_sym, attributes)
    else
      model.create! attributes
    end
    if(through)
      create through['model'], through['attributes'].merge(model.name.underscore.to_sym => obj)
    end
    obj
  end

  def find_or_create(model_or_modelo, attributes = {}, options = {}) 
    model = if model_or_modelo.is_a?(String)
      model_or_modelo.to_model
    else
      model_or_modelo
    end
    if attributes.any?
      attribs = Hash.new
      attributes.each do |key, value|
        if child_model = (key.to_s.to_model || key.to_s.to_relation_model)
          child = add_resource(child_model, field_for(child_model, 'nombre') => value)
          field_name = key.to_s.to_relation_model ? key : child_model.name.underscore
          attribs["#{field_name}_id"] = child.id
        else
          attribs[key] = value
        end
      end
      if ((options[:force_creation].nil? || !options[:force_creation])  &&
          obj = model.find(:first, :conditions => conditions_from_attributes(attribs)))
        if(through = attribs[:through])
          create through['model'], through['attributes'].merge(model.name.underscore.to_sym => obj)
        end
        obj
      else
        create model, attribs
      end
    else
      create model
    end
  end

  def conditions_from_attributes(attributes)
    attribs = attributes.reject {|k,v| k == :through} 
    [attribs.keys.map{|s| "#{s}=?"}.join(' AND ')] + attribs.values
  end

  def names_for_simple_creation(model, number, name_or_names, options = {})
    base_hash = base_hash_for(options)
    if name_or_names
      field = field_for(model, 'nombre')
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

  def field_for(model, campo = 'nombre')
    "#{model && model.name}::#{campo}".to_field || campo.to_field
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
  
  def last_mentioned_should_have_value(campo, valor)
    res = last_mentioned
    if child_model = campo.to_model
      child = child_model.find_by_name(valor)
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
      child = child_model.find_by_name(name)
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

end
