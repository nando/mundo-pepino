require 'rbconfig'

# This generator bootstraps a Rails project for use with MundoPepino, 
# an implemented set of Cucumber step definitions written in Spanish.
class MundoPepinoStepsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory 'features/support'
      m.file 'mundo_pepino_es_ES.rb', 'features/support/mundo_pepino_es_ES.rb'

      m.directory 'features/step_definitions'
      m.file '../../../lib/mundo_pepino/es_ES/definitions.rb', 'features/step_definitions/mundo_pepino_steps_es_ES.rb'

      m.directory 'lib/tasks'
      m.file      'mundo_pepino.rake',    'lib/tasks/mundo_pepino.rake'
    end
  end

protected

  def banner
    "Usage: #{$0} mundo_pepino_steps"
  end
end
