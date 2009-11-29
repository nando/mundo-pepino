module MundoPepino
  module Implementations

    def given_we_have_a_number_of_instances_called(params)
      model = params[:model].to_unquoted.to_model || raise(ModelNotMapped.new(params[:model]))
      number = params[:number].to_number
      attribs = names_for_simple_creation(model, number, params[:name])
      add_resource(model, attribs, :force_creation => true)
    end

    def given_resource_has_many_children(params)
      children_model = convert_to_model(params[:children_field])
      last_mentioned_resources(params[:model], params[:name]) do |resource|
        attribs = names_for_simple_creation(children_model, 
          params[:number_of_children].to_number, params[:children_names],
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
      do_visit params[:page].to_unquoted.to_url
    end

    def given_or_when_i_follow_the_link(params)
      if params[:selector]
        click_link_within params[:selector], params[:link]
      else
        click_link params[:link]
      end
    end

    def then_i_see_or_not_the_text(params)
      within params[:selector] || 'html' do
        response.send(
          shouldify(params[:should]), 
          contain(params[:text].to_unquoted.to_translated.to_regexp))
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
      add_resource_from_database(params[:model], params[:name])
      last_mentioned_should_have_n_children(params[:children_field], params[:number])
    end
  end
end
