
module MundoPepino
  module Matchers
    class Bites
      class << self
        include Fragments
      end
    end
  end
end

class << self
  MundoPepino::Matchers::Fragments.instance_methods(false).select{|m|
      m =~ /^_[a-z][a-z_]+[a-z]_/
  }.each do |method|
    delegate method, :to => 'MundoPepino::Matchers::Bites'
  end
end

