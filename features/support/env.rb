# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/app/config/environment')
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

require 'webrat/rails'

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
#require 'webrat/rspec-rails'

require 'mundo-pepino'

Before do
  [ Orchard,
    Terrace,
    Crop,
    Fertilizer,
    Tomato,
    Chard,
    Pepino
  ].each { |model| model.destroy_all }
end

String.model_mappings = {
  /huert[oa]s?/i            => Orchard,
  /bancal(es)?$/i           => Terrace,
  /cultivos?$/i             => Crop,
  /(abono|fertilizante)s?/i => Fertilizer,
  /tomates?$/i		    => Tomato,
  /acelgas?$/i		    => Chard,
  /pepinos?$/i		    => Pepino
}

String.field_mappings = {
  /[áa]reas?$/i    => 'area',
  /color(es)?$/i   => 'color',
  /latitud(es)?$/i => 'latitude',
  /longitud(es)?/i => 'length',
  /pesos?/i        => 'weight',
  /di[áa]metros?/i => 'diameter',
  /matas?$/i       => 'plants',
  /variedad(es)?$/i           => 'variety',
  /campos? de texto/i         => 'text_field',
  /[áa]reas? de texto/i       => 'textarea',
  /tipos? de cultivos?/i      => 'orchard_type',
  /nacionalidad/i             => 'nationality',
  /fichero adjunto/i          => 'file_field',
  /casilla seleccionada/i     => 'selected_check',
  /casilla sin seleccionar/i  => 'unselected_check',
  /Orchard::longitud(es)?$/   => 'longitude'
}



class MiMundo < MundoPepino 
  def entonces_campo_valor(campo, valor)
    if child_model = campo.to_model
      child = child_model.find_by_name(valor)
      (@then_resource.send child_model.name.downcase).should == child
    else
      (@then_resource.send field_for(@then_resource.class, campo)).to_s.should == valor
    end
  end
  
  def entonces_tiene_hijo(hijo, nombre)
    if child_model = hijo.to_model
      child = child_model.find_by_name(nombre)
      (@then_resource.send child_model.table_name).detect do |c|
        c.id == child.id 
      end.should_not be_nil
    else
      MundoPepino::ModelNotMapped.new(hijo)
    end
  end
end


World do
  MiMundo.new
end
