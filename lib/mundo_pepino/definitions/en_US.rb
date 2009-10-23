# MundoPepino's step definitions in en_US
module MundoPepino
  class << self
    def language_specific_mappings(world)
      String.add_mapper(:real_value, {
        /^tru(e|th)$/i  => true,
        /^false$/i       => false
      }) { |value| value }  # "true".to_real_value # => true
      String.add_mapper(:field, {:nombre => :name})
    
      String.add_mapper(:number, { 
        /^an?$/i    => 1,
        /^one$/i    => 1,
        /^first?$/i => 1,
        /^two$/i    => 2,
        /^second$/i => 2,
        /^three$/i  => 3,
        /^third$/i  => 3,
        /^four$/i   => 4,
        /^fourth$/i => 4,
        /^five$/i   => 5,
        /^fifth$/i  => 5}) { |string| string.to_i }
      String.add_mapper(:crud_action,
        /^creation$/i           => 'new',
        /^changes?$/i                => 'edit',
        /^modifications?$/i       => 'edit',
        /^editions?$/i            => 'edit') { |action| action }
      String.add_mapper(:month) { |month| month.capitalize }
      unless world.respond_to? :path_to
        String.url_mappings[/^the home\s?page/i] = world.root_path
      end
    end
  end
end

match_number = 'a|an|one|two|three|four|five|six|seven|eight|nine|ten|\d+'
which = '(?:which|that have as)'
# Simple creation w/ optional name/s
Given /^(?:that we have )?(#{match_number}) (?!.+ #{which})(.+?)(?: (?:called )?['"](.+)["'])?$/i do |number, model, name|
  given_we_have_a_number_of_instances_called number, model, name 
end

Then /^we have (#{match_number}) ([^ ]+)(?: (?:called )?['"](.+)["'])? in our database$/ do |number, model, names|
  then_we_have_a_number_of_instances_in_our_database number, model, names
end
