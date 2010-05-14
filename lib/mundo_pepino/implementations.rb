module MundoPepino
  module Implementations
    # Params:
    #   :model (raw)
    #   :number (f.e. "a", "three")
    #   :name ("Foo") or :names ("Foo, Fu and Kunfu") 
    def given_we_have_a_number_of_instances_called(params)
      model = params[:model].to_unquoted.to_model || raise(ModelNotMapped.new(params[:model]))
      number = params[:number].to_number
      attribs = names_for_simple_creation(model, number, params[:name])
      add_resource(model, attribs, :force_creation => true)
    end
    
    # Params:
    #   :model (raw)
    #   :table 
    def given_we_have_the_following_instances_from_step_table(params)
      model = convert_to_model(params[:model])
      add_resource model, translated_hashes(params[:table].raw, :model => model),
        :force_creation => true
    end

    # Params:
    #   :model
    #   :field
    #   :value
    #   :name (optional)
    def given_those_resources_have_value_in_field(params)
      if res = params[:name] ? [last_mentioned_of(params[:model], params[:name])] : last_mentioned_of(params[:model])

        if resource_not_respond_to_field?(res, params[:field]) && !resource_respond_to_relation_field?(res, params[:field])
          params.merge!(:children_field => params[:field], :children_names => params[:value])
          given_resource_has_many_children(params)
        else
          resources, field, values = resources_array_field_and_values(res, params[:field], params[:value])
          if field
            resources.each_with_index do |r, i|
              r.update_attribute field, real_value_for(values[i])
            end
            pile_up res
          else
            raise MundoPepino::FieldNotMapped.new(params[:field])
          end
        end
      end
    end

    # Params:
    # :model (raw) (optional)
    # :table
    # :name (optional)
    def given_resource_have_the_following_values_from_step_table(params)
      params[:model] = last_mentioned.class.name.downcase if params[:model].nil?

      params[:table].hashes.each do |hash|
        hash.each_pair do |campo, valor|
          given_those_resources_have_value_in_field :model => params[:model],
                                                    :name => params[:name],
                                                    :field => campo,
                                                    :value => valor
        end
      end
    end

    def given_resource_has_many_children(params)
      children_model = convert_to_model(params[:children_field])
      last_mentioned_resources(params[:model], params[:name]) do |resource|
        attribs = names_for_simple_creation(children_model, 
          (params[:number_of_children] || '1').to_number, params[:children_names],
          parent_options(resource, children_model, params[:children_field]))
        add_resource children_model, attribs, :force_creation => params[:children_names].nil?
      end
    end

    def given_resource_has_many_children_from_step_table(params)
      children_model = convert_to_model(params[:children_field])
      last_mentioned_resources(params[:model], params[:name]) do |resource|
        options = parent_options(resource, children_model, params[:children_field])
        options[:model] = children_model
        add_resource children_model, translated_hashes(params[:step_table].raw, options)
      end
    end

    def given_or_when_i_do_a_page_request(params)
      do_visit params[:page].to_unquoted.to_page
    end

    def given_or_when_i_follow_the_link(params)
      if params[:selector].blank?
        click_link params[:link]
      else
        click_link_within params[:selector], params[:link]
      end
    end

    def then_i_see_or_not_the_text(params)
      if params[:selector].blank?
        should_or_not_contain_text params
      else
        if defined?(Capybara)
          with_scope params[:selector] do
            should_or_not_contain_text params
          end
        else
          within params[:selector] do |content|
            should_or_not_contain_text content, params
          end
        end
      end
    end

    # DB CHECKS
    def then_we_have_a_number_of_instances_in_our_database(params)
      model = convert_to_model(params[:model])
      conditions = params[:name] && {:conditions => ["#{field_for(model)}=?", params[:name]]}
      resources = model.find(:all, conditions || {})
      resources.size.should == params[:number].to_number
      pile_up (resources.size == 1 ? resources.first : resources) if resources.size > 0
    end

    def then_resource_called_name_should_have_n_children(params)
      add_resource_from_database params[:model], params[:name]
      then_that_resource_should_have_n_children params
    end

    def then_that_resource_should_have_n_children(params) 
      last_mentioned_should_have_n_children(params[:children_field], params[:number])
    end

    def then_resource_called_name_should_have_value_in_field(params)
      add_resource_from_database(params[:model], params[:name])
      then_that_resource_should_have_value_in_field params
    end

    def then_that_resource_should_have_value_in_field(params)
      last_mentioned_should_have_value(params[:field], params[:value].to_real_value)
    end
    
    def then_resource_called_name_should_have_child(params)
      add_resource_from_database params[:model], params[:name]
      then_that_resource_should_have_child params
    end

    def then_that_resource_should_have_child(params)
      last_mentioned_should_have_child(params[:children_field], params[:child_name])
    end

    private
    def resource_not_respond_to_field?(res, field)
      res = res.is_a?(Array) ? res.first : res
      field.to_model && !res.respond_to?(field.to_model.name.downcase)
    end

    def resource_respond_to_relation_field?(res, field)
      res = res.is_a?(Array) ? res.first : res
      field_for(res.class, field) && res.respond_to?(field_for(res.class, field))
    end
  end
end
