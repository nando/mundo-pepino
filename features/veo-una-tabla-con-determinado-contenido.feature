Característica: Veo una tabla con un contenido concreto
  Escenario: Veo una tabla con un contenido concreto en sus celdas
  # Patrón:
  #   Entonces debería ver una tabla con el/los (siguiente/s)? contenido/s:
  # o:
  #   Entonces debo ver una tabla con el/los (siguiente/s)? contenido/s:
  # o:
  #   Entonces veo una tabla con el/los (siguiente/s)? contenido/s:
  #     | campo1 | campo2 |  ...  | campoN |
  #     | v1-1   | v2-2   |  ...  | v2-N   |
  #         .        .       ...      .
  #     | vN-1   | vN-2   |  ...  | vN-N   |
  #
  # Ejemplo:
  #   Entonces veo una tabla con el contenido:
  #     | nombre    | área | longitud | latitud   |
  #     | Regadío-1 | 15   | N 41° 35 | W 003° 48 |
  #     | Regadío-2 | 42   | N 41° 35 | W 003° 48 |
  #
  #   Como contenido de una celda puede utilizarse ".*" para indicar
  # cualquier valor.
  #

    Dado que tenemos el huerto:
        | nombre   | área | longitud | latitud   |
        | Secano-1 | 35   | N 40° 44 | W 003° 48 |
    Cuando visito la Página de Huertos
    #Entonces debería ver una tabla con el/los (siguiente/s)? contenido/s:
    Entonces debería ver una tabla con el siguiente contenido:
             | nombre   | área | longitud | latitud   |
             | Secano-1 | 35   | N 40° 44 | W 003° 48 |
           Y debería ver una tabla con el contenido:
             | nombre   | área | longitud | latitud   |
             | Secano-1 | 35   | N 40° 44 | W 003° 48 |
           Y debo ver una tabla con los siguientes contenidos:
             | nombre   | área | longitud | latitud   |
             | Secano-1 | 35   | N 40° 44 | W 003° 48 |
           Y veo una tabla con el contenido:
             | nombre   | área | longitud | latitud   |
             | Secano-1 | 35   | N 40° 44 | W 003° 48 |
           Y veo una tabla con el contenido:
             | nombre   | área | longitud | latitud   |
             | .*       | 35   | N 40° 44 | W 003° 48 |
    
