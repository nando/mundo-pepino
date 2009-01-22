require 'cucumber/rails/world'
require 'string-mapper'
require 'definiciones/dado_contexto'
require 'definiciones/cuando_ocurre'
require 'definiciones/entonces_pasa'

String.add_mapper :model
String.add_mapper(:field) { |str| :name if str =~ /nombres?/ }
String.add_mapper :name_field
String.add_mapper :model_field
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
  /^quit[ao]/i => 5}) { |string| string.to_i }
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
String.add_mapper(:local_path) { |string| string }
String.add_mapper(:underscored) { |string| string.gsub(/ +/, '_') }
String.add_mapper(:unquoted) { |str| str =~ /^['"](.*)['"]$/ ? $1 : str}

class MundoPepino < Cucumber::Rails::World
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
      self.m_model.name.downcase
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

  def create(model, attributes = {})
    if defined?(FixtureReplacement)
      attribs_for_fr = {}
      attributes.each do |k, v|
        if k =~ /^(.+)_id$/
          attribs_for_fr[$1.to_sym] = eval($1.capitalize).find(v.to_i)
        else
          attribs_for_fr[k] = v
        end
      end
      self.send "create_#{model.name.downcase}", attribs_for_fr
    else
      model.create! attributes
    end
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
          attribs[child_model.name.downcase + '_id'] = child.id
        else
          attribs[key] = value
        end
      end
      if ((options[:force_creation].nil? || !options[:force_creation])  &&
          obj = model.find(:first, :conditions =>
          [attribs.keys.map{|s| "#{s}=?"}.join(' AND ')] + attribs.values ))
        obj
      else
        create model, attribs
      end
    else
      create model
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

  def add_resource_from_database(modelo, nombre)
    model = modelo.to_unquoted.to_model
    field = field_for(model, 'nombre')
    if resource = model.send("find_by_#{field}", nombre)
      pile_up resource
    else
      NotFoundInDatabase.new(model, name)
    end
  end
  
  def pile_up(mentioned)
    @resources ||= []
    mentioned.class.send :include, Mencionado
    @resources.unshift mentioned
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
      else
        if (last_mentioned.is_a?(Array) and (last_mentioned.m_model == model))
          last_mentioned
        else
          detect_first @resources.flatten, model
        end
      end
      resource || raise(ResourceNotFound.new("model:#{model.name}, name:#{with_name||'nil'}"))
    else
      raise ModelNotMapped.new(modelo)
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
      { options[:parent].class.name.downcase + '_id' => options[:parent].id }
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
      [ child_model.name.downcase, values ]
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
      (res.send child_model.name.downcase).should == child
    elsif field = field_for(res.class, campo)
      (res.send field).to_s.should == valor
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
  
end
