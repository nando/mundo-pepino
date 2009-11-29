module MundoPepino
  class << self
    def language_specific_mappings
      String.real_value_mappings = {
        /^tru(e|th)$/i  => true,
        /^false$/i       => false
      }
      String.number_mappings = { 
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
        }
      String.crud_action_mappings = {
        /^creation$/i           => 'new',
        /^changes?$/i           => 'edit',
        /^modifications?$/i     => 'edit',
        /^editions?$/i          => 'edit'
      }
      String.url_mappings[/^the home\s?page/i] = self.world.root_path
    end
  end
end
