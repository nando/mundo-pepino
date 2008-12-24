Característica: asignación de un valor en un recurso concreto

  Escenario: Asignación de un valor en un campo de un recurso concreto
  ########################################################################
  # Patrón: 
  #   Dado que el/la _modelo_ "_nombre_" tiene como _campo_ "_valor_" (_unidades_)?
  # Ejemplos:
  #   Dado que la acelga "A" tiene como variedad "Gigante carmesí"
  #   Dado que el huerto "H-01" tiene como área "24" hectáreas
  #
  # Descripción:
  #     Asigna un _valor_ a un _campo_ del recurso cuya clase sea _modelo_
  #   y cuyo nombre sea _nombre_
  #
  #     Dicha asignación se llevará a cabo de acuerdo con lo siguiente:
  #
  #   - Si _campo_ está mapeado con un modelo el valor será el registro de 
  #     dicho modelo cuyo nombre sea _valor_, creándolo si no existe aún.
  #
  #   - En caso contrario se asignará directamente _valor_ a _campo_ 
  #
  ########################################################################
    Dado que tenemos dos huertos llamados "A y B"
       Y que el huerto "A" tiene como área "12" hectáreas
       Y que dicho huerto tiene como abono "Hidrogenado"
       Y que la huerta "B" tiene como área "8" hectáreas
       Y que dicho huerto tiene como abono "Estiércol líquido"
    Entonces el huerto "A" tiene en bbdd como área "12"
           Y tiene en bbdd como abono "Hidrogenado"
           Y el huerto "B" tiene en bbdd como área "8"
           Y tiene en bbdd como abono "Estiércol líquido"
