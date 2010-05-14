# language: es
Característica: asignación de valores en un recurso concreto desde fit table

  Escenario: Asignación de valores en un campo (atributo, belongs_to o has_one) de un recurso concreto desde fit table
  ########################################################################
  # Patrón:
  #   Dado que el _modelo_ "_nombre_" tiene:
  # o:
  #   Dado que dicho/a _modelo_ tiene:
  # seguido de:
  #     | campo1 | campo2 |  ...  | campoN |
  #     | v1-1   | v1-2   |  ...  | v1-N   |
  #
  # Ejemplo refiriéndonos a un recurso explícitamente:
  #
  #   Dado que el huerto "H-01" tiene:
  #     | longitud | latitud | area |
  #     |    12    | 10 |     15 |
  #
  #
  # Ejemplo haciendo referencia a un recurso mencionado:
  #
  #   Dado que dicho huerto tiene:
  #     | longitud | latitud |  area |
  #     |    12    | 10 |     15 |
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
       Y que el huerto "A" tiene:
       | longitud | latitud | area | bancal  |
       |     12   |    10   |  15  | patatas |
       Y que la huerta "B" tiene:
       | longitud | latitud | area | bancal  |
       |     6    |   5     |  8   | tomates |
       Y que tenemos un huerto llamado "C"
       Y que dicho huerto tiene:
       | longitud | latitud | area | bancal  |
       |    18    |   15    |  23  | berzas  |
       Y que tenemos un huerto llamado "D"
       Y que tiene:
       | longitud | latitud | area | bancal   |
       |    24    |   20    |  27  | puerros  |
    Entonces el huerto "A" tiene en bbdd como área "15"
           Y tiene en bbdd como longitud "12"
           Y tiene en bbdd como latitud "10"
           Y tiene en bbdd un bancal "patatas"
           Y el huerto "B" tiene en bbdd como área "8"
           Y tiene en bbdd como longitud "6"
           Y tiene en bbdd como latitud "5"
           Y tiene en bbdd un bancal "tomates"
           Y el huerto "C" tiene en bbdd como área "23"
           Y tiene en bbdd como longitud "18"
           Y tiene en bbdd como latitud "15"
           Y tiene en bbdd un bancal "berzas"
           Y el huerto "D" tiene en bbdd como área "27"
           Y tiene en bbdd como longitud "24"
           Y tiene en bbdd como latitud "20"
           Y tiene en bbdd un bancal "puerros"
