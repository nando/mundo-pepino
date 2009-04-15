require 'cucumber/rails/world'
require 'string-mapper'
begin
  module Cucumber::StepMethods
    alias_method :Dado, :Given
    alias_method :Cuando, :When
    alias_method :Entonces, :Then
  end
rescue
  # NO NEED TO CREATE ALIASES IN pre-0.2
end
require 'definiciones/dado_contexto'
require 'definiciones/cuando_ocurre'
require 'definiciones/entonces_pasa'

String.add_mapper(:real_value, {
  /^verdader[oa]$/i  => true,
  /^fals[ao]$/i      => false
}) { |value| value }
String.add_mapper :model
String.add_mapper(:field) { |str| :name if str =~ /nombres?/ }
String.add_mapper(:url, /^la (portada|home)/i => '/') do |string| 
  string if string =~ /^\/.*$|^https?:\/\//i
end

String.add_mapper(:number, { 
  /^un[oa]?$/i     => 1,
  /^primer[oa]?$/i => 1,
  :dos            => 2,
  /^segund[oa]?$/i => 2,
  :tres         => 3,
  /^tercer[ao]/i => 3,
  :cuatro      => 4,
  /^cuart[ao]/i => 4,
  :cinco       => 5,
  /^quint[ao]/i => 5}) { |string| string.to_i }
String.add_mapper(:crud_action,
  /^alta$/i                  => 'new',
  /^creaci[óo]n$/i           => 'new',
  /^nuev(?:o|a|o\/a|a\/o)$/i => 'new',
  /^cambio$/i                => 'edit',
  /^modificaci[oó]n$/i       => 'edit',
  /^edici[oó]n$/i            => 'edit')
String.add_mapper(:month,
  :enero           => 'January',
  :febrero         => 'February',
  :marzo           => 'March',
  :abril           => 'April',
  :mayo            => 'May',
  :junio           => 'June',
  :julio           => 'July',
  :agosto          => 'August',
  /^sep?tiembre$/i  => 'September',
  :octubre         => 'October',
  :noviembre       => 'November',
  :diciembre       => 'December')
String.add_mapper(:content_type,
  /\.png$/   => 'image/png',
  /\.jpe?g$/ => 'image/jpg',
  /\.gif$/   => 'image/gif') { |str| 'text/plain' }
String.add_mapper(:underscored) { |string| string.gsub(/ +/, '_') }
String.add_mapper(:unquoted) { |str| str =~ /^['"](.*)['"]$/ ? $1 : str}

module MundoPepino
  # API común para las instancias que van referenciándose en el escenario.
  module Mencionado 
    def m_instance
      self.is_a?(Array) ? self.first : self
    end
    
    def m_new_record?
      self.m_instance.new_record?
    end
    
    def m_model
      self.m_instance.class
    end
    
    def m_singular
      self.m_model.name.underscore
    end
    
    def m_plural
      self.m_model.table_name
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
	
  def real_value_for(v)
    (v.is_a?(String) ? v.to_real_value : v )
  end

  def parsed_attributes(raw_attributes)
    attributes = {}
    raw_attributes.each do |k, v|
      if k =~ /^(.+)_id$/
        if polymorph = raw_attributes.delete($1 + '_type')
          attributes[$1.to_sym] = eval(polymorph).find(v.to_i)
        else 
          attributes[$1.to_sym] = eval($1.capitalize).find(v.to_i)
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
        if child_model = key.to_s.to_model
          child = add_resource(child_model, field_for(child_model, 'nombre') => value)
          attribs[child_model.name.underscore + '_id'] = child.id
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

  def add_resource_from_database(modelo, nombre)
    model = modelo.to_unquoted.to_model
    field = field_for(model, 'nombre')
    if resource = model.send("find_by_#{field}", nombre)
      pile_up resource
    else
      NotFoundInDatabase.new(model, name)
    end
  end

  def do_visit(url)
    @visits ||= []
    @visits << url
    visit url
  end
  
  def pile_up(mentioned)
    @resources ||= []
    if mentioned != last_mentioned
      mentioned.class.send :include, Mencionado
      @resources.unshift mentioned
    end
    mentioned
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
    affirmative = 'debo|debo ver|veo|deber[ií]a|deber[íi]a ver'
    should_or_not =~ /^(#{affirmative})$/i ? :should : :should_not
  end

  def not_shouldify(should_or_not)
    shouldify(should_or_not) == :should ? :should_not : :should
  end

  def unquote(string_or_array)
    if string_or_array.is_a?(Array)
      string_or_array.map { |str| unquote(str) }
    else
      string_or_array =~ /^['"](.*)['"]$/ ? $1 : string_or_array
    end
  end
  
  def last_mentioned
    @resources && @resources.first
  end

  def last_mentioned_url 
    if mentioned = last_mentioned
      if mentioned.m_new_record?
        eval("#{mentioned.m_plural}_path")
      else
        eval("#{mentioned.m_singular}_path(#{mentioned.m_instance.id})")
      end
    else
      raise WithoutResources
    end
  end

  def last_mentioned_of(modelo, with_name = nil)
    if model = modelo.to_model
      resource = if with_name
        detect_first @resources.flatten, [model, with_name]
      elsif(last_mentioned.m_model == model)
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

  def recursive_group_search(model, resources)
    if lm = resources.shift
      if(lm.is_a?(Array) and (lm.m_model == model))
        lm
      else
        recursive_group_search(model, resources)
      end
    end
  end

  def last_visited
    @visits.last
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

  def detect_first(arr, value, method = nil)
    if value.is_a? String
      method ||= :name
      arr.detect { |r| r.respond_to?(method) && (r.send(method) =~ /#{value}/i) }
    elsif value.is_a? Class
      method ||= :is_a?
      arr.detect { |r| r.respond_to?(method) && r.send(method, value) }
    elsif value.is_a? Array
      model, val = value # [ class, value ]
      name_field = field_for(model, 'nombre')
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
      child_name_field = field_for(mentioned.m_model, 'nombre')
      values = add_resource(child_model,
        valores.map { |val| { child_name_field => val } })
      values = [ values ] unless values.is_a?(Array)
      [ child_model.name.underscore, values ]
    else
      [ field_for(mentioned.m_model, campo), valores ]
    end 
    [resources, field, values]
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
      (res.send child_model.name.underscore).should == child
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
  
  def method_missing(method, *args, &block)
    if (method.to_s =~ /^last_mentioned_(.+)$/)
      if mentioned = last_mentioned
        last_mentioned.send("m_#{$1}") 
      else
        nil
      end
    else
      super
    end
  end
  
  def find_field_and_do_with_webrat(action, campo, options = nil)
    do_with_webrat action, campo.to_unquoted, options # a pelo (localización vía labels)
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
