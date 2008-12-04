require File.expand_path(File.dirname(__FILE__) + '/../../../../config/environment')
require File.expand_path(File.dirname(__FILE__)) + '/../lib/string-mappings'
require 'spec'

describe 'String mapping' do
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

  it 'should translate models' do
    String.model_mappings[:vector] = Array
    'Vector'.to_model.should == Array
  end

  it 'should translate unmapped models to nil' do
    'Tabla'.to_model.should == nil
  end
end
