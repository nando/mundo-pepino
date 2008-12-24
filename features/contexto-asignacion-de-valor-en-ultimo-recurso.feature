Característica: asignación de un valor

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
  #   del _modelo_ mencionado
  #
  #     Dicha asignación se llevará a cabo de acuerdo con lo siguiente:
  #
  #   - Si _campo_ está mapeado con un modelo el valor será el registro de 
  #     dicho modelo cuyo nombre sea _valor_, creándolo si no existe aún.
  #
  #   - En caso contrario se asignará directamente _valor_ a _campo_.to_field 
  #
  #   Ejemplo de mapeo de campo:
  #
  #     String.field_mappings[/[áa]rea/i] = 'area'
  #
  #   Ejemplo de mapeo de modelo:
  #
  #     String.model_mappings[/(abono|fertilizante)s?$/i] = Fertilizer
  #
  ########################################################################
    Dado que tenemos un huerto llamado "H-01"
       Y que dicho huerto tiene como área "60" hectáreas
       Y que dicho huerto tiene como latitud "N 40° 44,340"
       Y que dicho huerto tiene como longitud "W 003° 48,730"
       Y que dicho huerto tiene como abono "Nitrogenado de 1ª calidad"
       Y que tenemos tres huertos llamados "H-02, H-03 y H-04"
       Y que dichos huertos tienen como área "20, 32 y 12" hectáreas
       Y que dichos huertos tienen como abono "Nitrogenado de 2ª calidad"
    Entonces el huerto "H-01" tiene en bbdd como área "60"
           Y tiene en bbdd como latitud "N 40° 44,340"
           Y tiene en bbdd como longitud "W 003° 48,730"
           Y tiene en bbdd como abono "Nitrogenado de 1ª calidad"
           Y el huerto "H-02" tiene en bbdd como área "20"
           Y tiene en bbdd como abono "Nitrogenado de 2ª calidad"
           Y el huerto "H-03" tiene en bbdd como área "32"
           Y tiene en bbdd como abono "Nitrogenado de 2ª calidad"
           Y el huerto "H-04" tiene en bbdd como área "12"
           Y tiene en bbdd como abono "Nitrogenado de 2ª calidad"

