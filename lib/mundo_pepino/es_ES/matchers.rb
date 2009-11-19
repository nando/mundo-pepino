module MundoPepino
  module Matchers
    module Fragments
      def _should_
        'debo|debo ver|veo|deber[ií]a|deber[íi]a ver|leo|debo leer|deber[ií]a leer'
      end
      def _numero_
        'un|una|dos|tres|cuatro|cinco|seis|siete|ocho|nueve|diez|\d+'
      end
      def _cuyo_
        '(?:cuy[oa]s?|que tienen? como)'
      end
      def _visito_
        '(?:visito|estoy en)'
      end
      def _la_pagina_
        'la (?:p[áa]gina|portada)'
      end
      def _el_listado_de_
        '(?:el|la) (?:p[áa]gina|portada|[íi]ndice|listado|colecci[óo]n) de'
      end
      def _pagina_desde_rutas_ # páginas obtenida a partir de las rutas
        '(?:la|el) \w+ del? |su p[aá]gina|su portada'
      end
      def _pulso_
        '(?:pulso|pincho|sigo)'
      end
      def _fecha_y_o_hora_
        '(?:(?:la )?fecha|hora)'
      end
      def _veo_o_no_
        '(?:no )?(?:veo|debo ver|deber[ií]a ver)'
      end
      def _leo_o_no_
        '(?:no )?(?:leo|debo leer|deber[íi]a leer)'
      end
      def _tenemos_en_bbdd_
        '(?:en (?:la )?(?:bb?dd?|base de datos) tenemos|tenemos en (?:la )?(?:bb?dd?|base de datos))'
      end
      def _tiene_en_bbdd_
        '(?:tiene en (?:la )?bbdd|en (?:la )?bbdd tiene|tiene en (?:la )?base de datos|en (?:la )?base de datos tiene)'
      end
      def _debo_estar_en_
        '(?:debo|deber[ií]a) (?:estar|encontrarme) en'
      end
      def _localizador_de_atributo_anidado_(capture=true)
        o,c = capture ? ['(', ')'] : ['', '']
        "(?:(?:el|la) )?#{o}.+?#{c} (?:del|de la) #{o}.+?#{c} ['\"]#{o}[^\"']+#{c}[\"']"
      end
      def _dentro_de_
        'dentro de(?: la etiqueta|l selector)?'
      end
      def _enlace_
        'enlace|(?:hiper)?-?v[íi]nculo' #TODO: |enlace ajax|enlace con efectos'
      end
      def _que_existe_
        '(?: que (?:hay|existe))?'
      end
      def _la_etiqueta_
        '(?:en )?(?:(?:una?|el|la) (?:selector|etiqueta|tag))'
      end
    end

    class << self
      include Fragments

      def page(expression)
        if mapped_page = expression.to_unquoted.to_url
          mapped_page
        elsif expression =~ /^(#{_el_listado_de_}) ([\w]+|['"][\w ]+["'])$/i
          MundoPepino.world.resource_index_or_mapped_page($1, $2)
        elsif expression =~ /^su (p[áa]gina|portada)$/i
          MundoPepino.world.last_mentioned_url
        elsif expression =~ /^#{_la_pagina_} (?:del|de la) (.+) ['"](.+)["']$/i
          modelo, nombre = $1, $2
          if resource = MundoPepino.world.last_mentioned_of(modelo, nombre)
            MundoPepino.world.send "#{resource.class.name.underscore}_path", resource
          else
            raise MundoPepino::ResourceNotFound.new("model #{modelo}, name #{nombre}")
          end
        elsif expression =~ /^#{_la_pagina_} de (?!la)([\w\/]+(?: de (?:una? )?nuev[oa])?) (?:de |de la |del )?(.+?)(?: (['"].+["']))?$/i
          accion, modelo, nombre = $1, $2, $3
          action = accion.to_crud_action or raise(MundoPepino::CrudActionNotMapped.new(accion))
          if action != 'new'
            nombre, modelo = modelo, nil unless nombre
            resource = if modelo && modelo.to_unquoted.to_model
              MundoPepino.world.last_mentioned_of(modelo, nombre.to_unquoted)
            else
              MundoPepino.world.last_mentioned_called(nombre.to_unquoted)
            end
            if resource
              MundoPepino.world.send "#{action}_#{resource.mr_singular}_path", resource
            else
              MundoPepino::ResourceNotFound.new("model #{modelo}, name #{nombre}")
            end
          else
            model = modelo.to_unquoted.to_model or raise(MundoPepino::ModelNotMapped.new(modelo))
            MundoPepino.world.pile_up model.new
            MundoPepino.world.send "#{action}_#{model.name.underscore}_path"
          end
        end
      end
    end
  end
end
require 'mundo_pepino/matchers_delegation'
