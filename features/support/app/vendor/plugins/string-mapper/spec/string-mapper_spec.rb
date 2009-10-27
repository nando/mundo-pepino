require File.expand_path(File.dirname(__FILE__)) + '/../lib/string-mapper'
require 'spec'

describe "String.add_mapper(:target)" do
  before(:all) do
    String.add_mapper(:target)
  end

  it 'should create a class mapping hash for target conversions' do
    String.target_mappings.should be_a_kind_of(Hash)
  end

  it 'should create an instance to_target method   topping hash for target' do
    'Source string'.should respond_to(:to_target)
  end

  it 'should return nil for an unmapped String instance' do
    'unmapped string'.to_target.should be_nil
  end

  it 'should convert from RegExps' do
    String.target_mappings[/(an?|one)$/i] = 1
    %{a an one A AN ONE}.each do |number| 
      number.to_target.should == 1
    end
  end

  it 'should convert from a String ignoring case' do
    String.target_mappings['one million'] = 1000000
    'One million'.to_target.should be(1000000)
  end

  it 'should convert from a Symbol ignoring case' do
    String.target_mappings[:four] = 4
    'FOUR'.to_target.should be(4)
  end

  it 'should map something target to "false" (boolean false)' do
    String.target_mappings['not be truth'] = false
    'not be truth'.to_target.should be(false)
  end

  it 'should convert from RegExps using matched captures in the returned value' do
    String.target_mappings[/In the (.+) of the (.+)$/i] = '#{$1.downcase}-of-the-#{$2.downcase}'
    'In the Name of the Father'.to_target.should == 'name-of-the-father'
  end

  it 'should execute the value if it is a Proc object' do
    def new_world_url
      '/worlds/new'
    end
    String.target_mappings['new world'] = lambda { new_world_url }
    'new world'.to_target.should == new_world_url
  end
end

describe "String.add_mapper(:target) { |str| default_value_block }" do
  it 'should use default_value_block to convert unmapped strings' do
    String.add_mapper(:number) { |str| str.to_i }
    '1000'.to_number.should == 1000
    'nothing'.to_number.should == 0 # not nil
  end
end

describe "String.add_mapper(:target, {mapping_hash} )" do
  it 'should use {mapping hash} to convert strings' do
    String.add_mapper(:class, :vector => Array)
    'vector'.to_class.should be(Array)
  end
end
