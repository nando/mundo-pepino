# Este generador crea una plantilla de caracteristica (feature) ligada a un modelo
module Rails::Generator::Commands
  MUNDO_PEPINO_ENV = 'caracteristicas/support/mundo_pepino_env.rb'

  MODEL_CLEANING = '"\n    # ENTRADA AUTO-GENERADA PARA #{model}\n' +
                   '    #{model}, # ' +
                   '(TODO: quitar la coma final si es el primer modelo)\n"'

  MODEL_MAPPING = '"\n  # MAPEO DE MODELO AUTO-GENERADO (#{model})\n' +
                  '  /^#{regexp}$/i => #{model},' + 
                  ' # (TODO: validar RegExp para forma plural y coma final)\n"'

  FIELD_MAPPING = '"\n  # MAPEO DE CAMPO AUTO-GENERADO (#{field})\n' +
                  '  /^#{regexp}$/i => :#{field},' + 
                  ' # (TODO: validar RegExp para forma plural y coma final)\n"'

  class Create < Base
    def mp_model_cleaning(model)
      add_to_mundo_pepino_env "MundoPepino::ModelsToClean = [", eval(MODEL_CLEANING)
      logger.model_cleaning "added #{model} (#{model}.destroy_all call before each scenario)"
    end

    def mp_model_mapping(model, regexp)
      add_to_mundo_pepino_env 'String.model_mappings = {', eval(MODEL_MAPPING)
      logger.model_mapping " added /^#{regexp}$/i => #{model}"
    end

    def mp_field_mapping(field, regexp)
      add_to_mundo_pepino_env 'String.field_mappings = {', eval(FIELD_MAPPING)
      logger.field_mapping " added /^#{regexp}$/i => :#{field}"
    end

    private
    def add_to_mundo_pepino_env(sentinel, content)
      unless options[:pretend]
        gsub_file MUNDO_PEPINO_ENV, /(#{Regexp.escape(sentinel)})/mi do |match|
          "#{match}#{content}"
        end
      end
    end
  end

  class Destroy < RewindBase
    def mp_model_cleaning(model)
      remove_from_mundo_pepino_env eval(MODEL_CLEANING)
      logger.model_cleaning "removing Before { #{model}.destroy_all }"
    end

    def mp_model_mapping(model, regexp)
      remove_from_mundo_pepino_env eval(MODEL_MAPPING)
      logger.model_mapping " removing /^#{regexp}$/i => #{model}"
    end

    def mp_field_mapping(field, regexp)
      remove_from_mundo_pepino_env eval(FIELD_MAPPING)
      logger.model_mapping " removing /^#{regexp}$/i => #{field}"
    end

    private
    def remove_from_mundo_pepino_env(content)
      unless options[:pretend]
        gsub_file MUNDO_PEPINO_ENV, /(#{Regexp.escape(content)})/mi, ''
      end
    end
  end
end

class CaracteristicaGenerator < Rails::Generator::NamedBase
  attr_reader :modelo_en_singular, :campos

  def manifest
    record do |m|
      if args.any?
        @modelo_en_singular = args.shift
        m.mp_model_cleaning class_name
        m.mp_model_mapping class_name, plural_regexp(modelo_en_singular)
        named_args.each do |arg|
          m.mp_field_mapping arg.name, plural_regexp(arg.nombre)
        end
      end
      m.template  'caracteristica.erb',
        "caracteristicas/gestion_de_#{modelo_en_plural.downcase}.feature"
    end
  end

  def named_args
    @named_args ||= args.map{|arg| NamedArg.new(arg)}
  end

  def modelo_en_plural
    modelo_en_singular + (modelo_en_singular =~ /[aeiou]$/i ? 's' : 'es')
  end

  def plural_regexp(nombre)
    suffix = if nombre =~ /[aeiou]$/i
      's?'
    else
      '(es)?'
    end
    nombre.downcase + suffix
  end

  class NamedArg
    attr_reader :name, :nombre

    def initialize(s)
      @name, @type, @nombre = *s.split(':')
    end

    def value(n=0)
      if @type == 'boolean'
        (n % 2) == 0
      elsif @type == 'integer'
        n
      else
        "#{@nombre} #{n}"
      end
    end
  end

protected

  def banner
    "Usage: #{$0} caracteristica ModelName NombreDelModelo [field:type:campo, field:type:campo]"
  end
end
