module MundoPepino
  module Matchers
    class Bites
      class << self
        def _number_
          'a|an|one|two|three|four|five|six|seven|eight|nine|ten|\d+'
        end
        def _which_
          '(?:which|that have as)'
        end
      end
    end
  end
end

class << self
  delegate :_number_, :_which_, :to => 'MundoPepino::Matchers::Bites'
end

