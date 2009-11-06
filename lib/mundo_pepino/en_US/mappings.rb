module MundoPepino
  class << self
    def language_specific_mappings
      String.add_mapper(:real_value, {
        /^tru(e|th)$/i  => true,
        /^false$/i       => false
      }) { |value| value }  # "true".to_real_value # => true
      String.add_mapper(:field)
    
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
        /^fifth$/i  => 5,
        /^six$/i    => 6,
        /^seven$/i  => 7,
        /^eight$/i  => 8,
        /^nine$/i   => 9,
        /^ten$/i    => 10 
        }) { |string| string.to_i }
      String.add_mapper(:crud_action,
        /^creation$/i           => 'new',
        /^changes?$/i                => 'edit',
        /^modifications?$/i       => 'edit',
        /^editions?$/i            => 'edit') { |action| action }
      String.add_mapper(:month) { |month| month.capitalize }
      unless self.world.respond_to? :path_to
        String.url_mappings[/^the home\s?page/i] = self.world.root_path
      end
    end
  end
end
