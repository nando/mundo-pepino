# Este generador crea una plantilla de caracteristica (feature) ligada a un modelo
module Rails::Generator::Commands
  MUNDO_PEPINO_ENV = 'caracteristicas/support/mundo_pepino_env.rb'

  MODEL_CLEANING = '"\n    # ENTRADA AUTO-GENERADA PARA #{model}\n' +
                   '    #{model}, # ' +
                   '(TODO: quitar la coma final si no es correcta)\n"'

  MODEL_MAPPING = '"\n  # MAPEO DE MODELO AUTO-GENERADO (#{model})\n' +
                  '  /#{modelo.downcase}s?$/i => #{model},' + 
                  ' # (TODO: validar RegExp para forma plural y coma final)\n"'

  FIELD_MAPPING = '"\n  # MAPEO DE CAMPO AUTO-GENERADO (#{field})\n' +
                  '  /#{campo.downcase}s?$/i => \'#{field}\',' + 
                  ' # (TODO: validar RegExp para forma plural y coma final)\n"'

  class Create < Base
    def mp_model_cleaning(model)
      add_to_mundo_pepino_env "Before do\n  [", eval(MODEL_CLEANING)
      logger.model_cleaning "added Before { #{model}.destroy_all }"
    end

    def mp_model_mapping(model, modelo)
      add_to_mundo_pepino_env 'String.model_mappings = {', eval(MODEL_MAPPING)
      logger.model_mapping " added /#{modelo.downcase}s?$/i => #{model}"
    end

    def mp_field_mapping(field, campo)
      add_to_mundo_pepino_env 'String.field_mappings = {', eval(FIELD_MAPPING)
      logger.field_mapping " added /#{campo}s?$/i => #{field}"
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

    def mp_model_mapping(model, modelo)
      remove_from_mundo_pepino_env eval(MODEL_MAPPING)
      logger.model_mapping " removing /#{modelo.downcase}s?$/i => #{model}"
    end

    def mp_field_mapping(field, campo)
      remove_from_mundo_pepino_env eval(FIELD_MAPPING)
      logger.model_mapping " removing /#{campo}s?$/i => #{field}"
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

  def initialize(runtime_args, runtime_options = {})
    super
    @campos = []
  end
  
  def manifest
    record do |m|
      if args.any?
        @modelo_en_singular = args.shift
        m.mp_model_cleaning class_name
        m.mp_model_mapping class_name, modelo_en_singular
        args.each do |arg|
          field, campo = arg.split(':')
          @campos << campo
          m.mp_field_mapping field, campo
        end
      end
      m.template  'caracteristica.erb', "caracteristicas/gestion_de_#{plural_name}.feature"
    end
  end

  def modelo_en_plural
    modelo_en_singular + (modelo_en_singular =~ /[aeiou]$/i ? 's' : 'es')
  end

protected

  def banner
    "Usage: #{$0} caracteristica ModelName NombreDelModelo [field:campo, field:campo]"
  end
end
