module MundoPepino
  module Implementations
    def we_have_a_number_of_instances_called(numero, modelo, nombre)
      if model = modelo.to_unquoted.to_model
        number = numero.to_number
        attribs = names_for_simple_creation(model, number, nombre)
        add_resource(model, attribs, :force_creation => true)
      else
        raise MundoPepino::ModelNotMapped.new(modelo)
      end
    end
  end
end
