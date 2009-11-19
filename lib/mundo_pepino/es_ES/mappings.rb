module MundoPepino
  class << self
    def language_specific_mappings
      String.add_mapper(:real_value, {
        /^verdader[oa]$/i  => true,
        /^fals[ao]$/i      => false
      }) { |value| value }
      String.add_mapper(:field) { |str| :name if str =~ /^nombres?/ }
      
      String.add_mapper(:number, { 
        /^un[oa]?$/i     => 1,
        /^primer[oa]?$/i => 1,
        :dos             => 2,
        /^segund[oa]?$/i => 2,
        :tres            => 3,
        /^tercer[ao]/i   => 3,
        :cuatro          => 4,
        /^cuart[ao]/i    => 4,
        :cinco           => 5,
        /^quint[ao]/i    => 5,
        :seis            => 6,
        :siete           => 7,
        :ocho            => 8,
        :nueve           => 9,
        :diez            => 10
      }) { |string| string.to_i }
      String.add_mapper(:crud_action,
        /^alta(?: de (?:una? )?nuev[ao])?$/i         => 'new',
        /^creaci[óo]n(?: de (?:una? )?nuev[ao])?$/i  => 'new',
        /^nuev(?:o|a|o\/a|a\/o)$/i => 'new',
        /^cambio$/i                => 'edit',
        /^modificaci[oó]n(?:es)?$/i       => 'edit',
        /^edici[oó]n$/i            => 'edit')
      String.add_mapper(:month,
        :enero           => 'January',
        :febrero         => 'February',
        :marzo           => 'March',
        :abril           => 'April',
        :mayo            => 'May',
        :junio           => 'June',
        :julio           => 'July',
        :agosto          => 'August',
        /^sep?tiembre$/i  => 'September',
        :octubre         => 'October',
        :noviembre       => 'November',
        :diciembre       => 'December')
      unless self.world.respond_to? :path_to
        String.url_mappings[/^la (?:portada|home\s?(?:page)?)$/i] = self.world.root_path
      end
    end
  end
end
