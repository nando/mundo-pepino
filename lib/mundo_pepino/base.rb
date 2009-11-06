module MundoPepino
  module Base
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
            child = add_resource(child_model, field_for(child_model) => value)
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
  end
end
