# language: es
Característica: asignación de un valor en un recurso concreto

  Escenario: Asignación de un valor en un campo (atributo, belongs_to o has_one) de un recurso concreto
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
       Y que tenemos dos usuarios "jacinto y tomasa"
       Y que el usuario "jacinto" tiene un perfil "Jacinto"
       Y que la usuaria "tomasa" tiene 1 perfil
    Entonces el huerto "A" tiene en bbdd como área "12"
           Y tiene en bbdd como abono "Hidrogenado"
           Y el huerto "B" tiene en bbdd como área "8"
           Y tiene en bbdd como abono "Estiércol líquido"
           Y tenemos en bbdd 2 perfiles
           Y el usuario "jacinto" tiene en bbdd un perfil "Jacinto"
           Y la usuaria "tomasa" tiene en bbdd un perfil
