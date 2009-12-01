Característica: asignación de un valor en el/los último/s resurso/s mencionado/s

  Escenario: Asignación de un valor en un campo de los últimos recursos definidos
  ########################################################################
  # Patrón: 
  #   Dado que dicho/a (_modelo_)? tiene/n como _campo_ "_valor_" (_unidades_)?
  #
  # Ejemplos:
  #   Dado que dicho huerto tiene como área "25" hectáreas
  #   Dado que dichas huertas tienen como abono "Nitrogenado de 1ª calidad"
  #
  # Descripción:
  #     Asigna un _valor_ a un _campo_ del último o últimos recursos definidos
  #   del _modelo_ mencionado. El campo puede ser un atributo normal, una
  #   relación :belongs_to o una relación :has_one.
  #
  #     Dicha asignación se llevará a cabo de acuerdo con lo siguiente:
  #
  #   - Si _campo_ está mapeado con un modelo el valor será el registro de 
  #     dicho modelo cuyo nombre sea _valor_, creándolo si no existe aún.
  #
  #   - En caso contrario se asignará directamente _valor_ a _campo_.to_field 
  #
  #   Ejemplo de mapeo de modelo y campo:
  #
  #     MundoPepino.configure do |config|
  #       config.model_mappings[/(abono|fertilizante)s?$/i] = Fertilizer
  #       config.field_mappings[/[áa]rea/i] = 'area'
  #     end
  #
  ########################################################################
    Dado que tenemos un usuario "jacinto"
       Y que dicho usuario tiene un perfil "Jacinto"
       Y que tenemos una usuaria "tomasa"
       Y que dicha usuaria tiene 1 perfil
       Y que tenemos tres huertos llamados "H-02, H-03 y H-04"
       Y que dichos huertos tienen como área "20, 32 y 12" hectáreas
       Y que dichos huertos tienen como abono "Nitrogenado de 2ª calidad"
       Y que tenemos un huerto llamado "H-01"
       Y que dicho huerto tiene como área "60" hectáreas
       Y que dicho huerto tiene como latitud "N 40° 44,340"
       Y que dicho huerto tiene como longitud "W 003° 48,730"
       Y que dicho huerto tiene como abono "Nitrogenado de 1ª calidad"
    Cuando visito su página
    Entonces debo ver la etiqueta H2 con el valor "H-01"
           Y el huerto "H-01" tiene en bbdd como área "60"
           Y tiene en bbdd como latitud "N 40° 44,340"
           Y tiene en bbdd como longitud "W 003° 48,730"
           Y tiene en bbdd como abono "Nitrogenado de 1ª calidad"
           Y el huerto "H-02" tiene en bbdd como área "20"
           Y tiene en bbdd como abono "Nitrogenado de 2ª calidad"
           Y el huerto "H-03" tiene en bbdd como área "32"
           Y tiene en bbdd como abono "Nitrogenado de 2ª calidad"
           Y el huerto "H-04" tiene en bbdd como área "12"
           Y tiene en bbdd como abono "Nitrogenado de 2ª calidad"
           Y el usuario "jacinto" tiene en bbdd un perfil "Jacinto"
           Y la usuaria "tomasa" tiene en bbdd un perfil
           Y tenemos en bbdd 2 perfiles

  Escenario: Con nombre de relacion que no se corresponde con su modelo asociado
    Dado que tenemos un huerto llamado "de secano"
       Y que tenemos una lechuga "seca"
       Y que dicha lechuga tiene como huerto de nacimiento "de secano"
    Entonces tenemos en bbdd un huerto
           Y tenemos en bbdd una lechuga
           Y la lechuga "seca" tiene en bbdd como huerto de nacimiento "de secano"

  Escenario: En un modelo cuyo campo "nombre" sea distinto de "name"
    Dado que tenemos un bancal llamado "Primer bancal"
       Y que tenemos un pepino "Primer pepino"
       Y que dicho pepino tiene como bancal "Primer bancal"
    Entonces el pepino "Primer pepino" tiene en bbdd como bancal "Primer bancal"
