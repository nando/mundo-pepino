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
        '(?:visito|estoy en|voy a)'
      end
      def _la_pagina_
        'la (?:p[áa]gina|portada)'
      end
      def _el_listado_de_
        '(?:el|la|al|a la) (?:p[áa]gina|portada|[íi]ndice|listado|colecci[óo]n) de'
      end
      def _pulso_
        '(?:pulso|pincho|sigo|hago click en)'
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
        "(?:(?:el|la) )?#{o}.+?#{c} de(?:l| la| su nuev[oa]) #{o}.+?#{c}(?: ['\"]#{o}[^\"']+#{c}[\"'])?"
      end
      def _dentro_de_
        'dentro de(?: la etiqueta|l selector)?'
      end
      def _el_enlace_
        'el (?:enlace|(?:hiper)?-?v[íi]nculo)(?: a)?' #TODO: |enlace ajax|enlace con efectos'
      end
      def _que_existe_
        '(?: que (?:hay|existe))?'
      end
      def _la_etiqueta_
        '(?:en )?(?:(?:una?|el|la) (?:selector|etiqueta|tag))'
      end
    end
  end
end
require 'mundo_pepino/matchers_delegation'
