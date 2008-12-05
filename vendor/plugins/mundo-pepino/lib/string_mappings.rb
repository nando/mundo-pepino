class String
  %w{ number model field }.each do |name|
    cattr_accessor(name + '_mappings')
    eval('@@' +  name + '_mappings = {}')

    define_method 'to_' +  name do
      mapping = nil
      String.send(name + '_mappings').each do |key, value|
        regexp = if key.is_a?(Regexp)
          key
        else
          Regexp.new(key.to_s, Regexp::IGNORECASE)
        end
        (mapping = value) && break if self =~ regexp
      end
      mapping || if self.respond_to?('default_' + name)
        self.send('default_' + name)
      else
        nil
      end
    end
  end

  def default_number
    self.to_i
  end

end
