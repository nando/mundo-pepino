# http://stackoverflow.com/questions/2135247/ruby-1-9-doesnt-support-unicode-normalization-yet
module ActiveSupport
  module Inflector
    # Calling String#parameterize prints a warning under Ruby 1.9,
    # even if the data in the string doesn't need transliterating.
    if Rails.version =~ /^2\.3/
      undef_method :transliterate
      def transliterate(string)
        string.dup
      end
    end
  end
end

