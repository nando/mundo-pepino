require 'rbconfig'

# This generator bootstraps a Rails project for use with MundoPepino, 
# an implemented set of Cucumber step definitions written in Spanish.
class MundoPepinoGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory 'caracteristicas/support'
      m.file 'mundo_pepino_env.rb', 'caracteristicas/support/mundo_pepino_env.rb'

      m.directory 'lib/tasks'
      m.file      'mundo_pepino.rake',    'lib/tasks/mundo_pepino.rake'
    end
  end

protected

  def banner
    "Usage: #{$0} mundo_pepino"
  end
end
