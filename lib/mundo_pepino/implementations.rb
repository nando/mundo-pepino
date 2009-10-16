module MundoPepino
  module Implementations
    def given_we_have_a_number_of_instances_called(raw_number, raw_model, name)
      if model = raw_model.to_unquoted.to_model
        number = raw_number.to_number
        attribs = names_for_simple_creation(model, number, name)
        add_resource(model, attribs, :force_creation => true)
      else
        raise MundoPepino::ModelNotMapped.new(raw_model)
      end
    end

    # DB CHECKS
    def then_we_have_a_number_of_instances_in_our_database(raw_number, raw_model, name)
      model = raw_model.to_unquoted.to_model
      conditions = if name
        {:conditions => [ "#{field_for(model, 'nombre')}=?", name ]}
      else
        {}
      end
      resources = model.find(:all, conditions)
      resources.size.should == raw_number.to_number
      if resources.size > 0
        pile_up (resources.size == 1 ? resources.first : resources)
      end

    end
  end
end
