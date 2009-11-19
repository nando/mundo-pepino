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

    def given_resource_has_many_children(params)
      if mentioned = last_mentioned_of(params[:resource_model].to_unquoted, params[:resource_name])
        children_model = params[:children_model].to_unquoted.to_model
        resources = (mentioned.is_a?(Array) ? mentioned : [mentioned])
        resources.each do |resource|
          attribs = names_for_simple_creation(children_model, 
            params[:number_of_children].to_number, params[:children_names],
            parent_options(resource, children_model))
          add_resource children_model, attribs, :force_creation => params[:children_names].nil?
        end
        pile_up mentioned
      end
    end

    def given_resource_has_many_children_from_step_table(params)
      if mentioned = last_mentioned_of(params[:resource_model].to_unquoted, params[:resource_name])
        children_model = params[:children_model].to_unquoted.to_model
        resources = (mentioned.is_a?(Array) ? mentioned : [mentioned])
        resources.each do |resource|
          options = parent_options(resource, children_model)
          options[:model] = children_model
          add_resource children_model, 
            translated_hashes(params[:step_table].raw, options)
        end
      end
    end

    def given_or_when_i_do_a_page_request(page)
      do_visit MundoPepino::Matchers.page(page)
    end

    def then_i_see_or_not_the_text(should, text, selector=nil)
      within selector || 'html' do
        response.send shouldify(should), contain(text.to_unquoted.to_translated.to_regexp)
      end
    end

    def given_or_when_i_follow_the_link(link, selector=nil)
      if selector
        click_link_within selector, link
      else
        click_link link
      end
    end

    # DB CHECKS
    def then_we_have_a_number_of_instances_in_our_database(raw_number, raw_model, name)
      model = raw_model.to_unquoted.to_model
      conditions = if name
        {:conditions => [ "#{field_for(model)}=?", name ]}
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
