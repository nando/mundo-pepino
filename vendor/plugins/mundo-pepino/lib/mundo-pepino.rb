require 'string-mappings'
require 'definiciones/dado_contexto'

class MundoPepino < Cucumber::Rails::World
  include FixtureReplacement

  def add_resource(resource)
    @resources ||= []
    @resources << resource
  end
end
