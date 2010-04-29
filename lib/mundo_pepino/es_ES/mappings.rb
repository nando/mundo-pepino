# encoding: UTF-8
module MundoPepino
  class << self
    include Matchers::Fragments
    def language_specific_mappings
      String.field_mappings[/^nombres?/i] = :name
      String.real_value_mappings = {
        /^verdader[oa]$/i  => true,
        /^fals[ao]$/i      => false
      }
      String.number_mappings = { 
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
      }
      String.crud_action_mappings = {
        /^alta(?: de (?:una? )?nuev[ao])?$/i         => 'new',
        /^creaci[óo]n(?: de (?:una? )?nuev[ao])?$/i  => 'new',
        /^nuev(?:o|a|o\/a|a\/o)$/i                   => 'new',
        /^inicio|comienzo$/i                         => 'new',
        /^cambio$/i                                  => 'edit',
        /^modificaci[oó]n(?:es)?$/i                  => 'edit',
        /^edici[oó]n$/i                              => 'edit'
      }
      String.month_mappings = {
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
        :diciembre       => 'December'
      }
      String.automagical_page_mappings.merge!({
        /^la (?:portada|home\s?(?:page)?)$/i => lambda{MundoPepino.world.root_path},
        /^(#{_el_listado_de_}) ([\w]+|['"][\w ]+["'])$/i => 
          lambda{ |el_listado_de, modelo|
            MundoPepino.world.resource_index_or_mapped_page(el_listado_de, modelo)
          },
        /^su (?:p[áa]gina|portada)$/i => lambda{MundoPepino.world.last_mentioned_url},
        # "la página de dicha huerta" + "la página de la huerta 'grande'"
        /^(?:#{_la_pagina_}|#{_el_enlace_}) de(?:l| la| dich[oa]) (.+?)(?: ['"](.+)["'])?$/i =>
          lambda{|modelo, nombre|
            if resource = MundoPepino.world.last_mentioned_of(modelo, nombre)
              MundoPepino.world.pile_up resource
              MundoPepino.world.send "#{resource.class.name.underscore}_path", resource
            else
              raise MundoPepino::ResourceNotFound.new("model #{modelo}"+(nombre ? ", name #{nombre}":''))
            end
          },
        # "la página de creación de huertos" y "la página de edición del huerto 'grande'"
        /^(?:#{_la_pagina_}|#{_el_enlace_}) de (?!la|dich[ao])([\w\/]+(?: de (?:una? )?nuev[oa])?) (?:de |de la |del )?(.+?)(?: (['"].+["']))?$/i => 
          lambda{|accion, modelo, nombre|
            action = accion.to_crud_action or raise(MundoPepino::CrudActionNotMapped.new(accion))
            if action != 'new'
              nombre, modelo = modelo, nil unless nombre
              resource = if modelo && modelo.to_unquoted.to_model
                MundoPepino.world.last_mentioned_of(modelo, nombre.to_unquoted)
              else
                MundoPepino.world.last_mentioned_called(nombre.to_unquoted)
              end
              if resource
                MundoPepino.world.pile_up resource
                MundoPepino.world.send "#{action}_#{resource.mr_singular}_path", resource
              else
                MundoPepino::ResourceNotFound.new("model #{modelo}, name #{nombre}")
              end
            else
              model = modelo.to_unquoted.to_model or raise(MundoPepino::ModelNotMapped.new(modelo))
              if dummy_instance = model.new rescue nil
                MundoPepino.world.pile_up dummy_instance
              end
              MundoPepino.world.send "#{action}_#{model.name.underscore}_path"
            end
          },
        /la (anterior|siguiente|p[aá]gina) (anterior|siguiente|p[aá]gina)/i =>
          lambda{|first, second|
            head, current, tail = if MundoPepino.world.last_visited =~ /(.+page=)(\d+)(.*)/
              [$1, $2.to_i, $3]
            else
              [MundoPepino.world.last_visited + '?page=', 1, '']
            end
            go_next = (first =~ /siguiente/i) || (second =~ /siguiente/i)
            "#{head}#{go_next ? current + 1 : current - 1}#{tail}"
          }
        })
    end
  end
end
