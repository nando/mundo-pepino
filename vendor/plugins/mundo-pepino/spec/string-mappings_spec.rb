require File.expand_path(File.dirname(__FILE__) + '/../../../../config/environment')
require File.expand_path(File.dirname(__FILE__)) + '/../lib/string_mappings'
require 'spec'

describe 'String mapping' do
  # NUMBERS ###########################################
  it 'should translate numbers' do
    # With a regexp...
    String.number_mappings[/una?/i] = 1 
    %{un uno UNO UN}.each do |numero| 
      numero.to_number.should == 1
    end
    # a string...
    String.number_mappings['dos'] = 2
    'DOS'.to_number.should == 2
    # or a symbol
    String.number_mappings[:tres] = 3
    'Tres'.to_number.should == 3
  end

  it 'should translate unmapped numbers to_i' do
    '1000'.to_number.should == 1000
    'ningún'.to_number.should == 0
  end

  # MODELS ###########################################
  it 'should translate models' do
    String.model_mappings[:vector] = Array
    'Vector'.to_model.should == Array
  end

  it 'should translate unmapped models to nil' do
    'Tabla'.to_model.should == nil
  end

  # FIELDS (column names) ############################
  it 'should translate fields (column names)' do
    String.field_mappings[/nombres?/i] = :name
    'Nombre'.to_field.should == :name
    'nombreS'.to_field.should == :name
  end

  it 'should translate unmapped fields to nil' do
    'Apellidos'.to_field.should == nil
  end

  # URLs #############################################
  it 'should translate URLs' do
    String.url_mappings[/la (portada|home)/i] = '/'
    'la portada'.to_url.should == '/'
    'LA HOME'.to_url.should == '/'
  end

  it 'should translate unmapped URLs to themselves' do
    '/index.html'.to_url.should == '/index.html'
  end

end
