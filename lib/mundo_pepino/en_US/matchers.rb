module MundoPepino
  module Matchers
    module Fragments
      def _should_
        'should|must'
      end
      def _should_or_not_
        'should(?: not)?'
      end
      def _number_
        'a|an|one|two|three|four|five|six|seven|eight|nine|ten|\d+'
      end
      def _which_
        '(?:which|that have as)'
      end
    end
  end
end
require 'mundo_pepino/matchers_delegation'
