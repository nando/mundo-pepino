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
      def _pagina_
        '(?:p[áa]gina|portada|[íi]ndice|listado|colecci[óo]n)'
      end
      def _pagina_desde_rutas_ # páginas obtenida a partir de las rutas
        '(?:la|el) \w+ del? |su p[aá]gina|su portada'
      end
      def _pulso_
        '(?:pulso|pincho)'         
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
    end
  end
end
require 'mundo_pepino/matchers_delegation'
