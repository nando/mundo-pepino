# language: es
Característica: Veo una tabla con un contenido concreto
  Escenario: Veo una tabla con un contenido concreto en sus celdas
  # Patrón:
  #   Entonces debo ver una tabla con el/los (siguiente/s)? contenido/s:
  # o:
  #   Entonces debo ver la tabla "_table_id_" con el/los (siguiente/s)? contenido/s:
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
  #  Si en la página hay varias tablas necesitaremos especificar en cual de
  # ellas debe realizarse la comprobación. Para ello tenemos que indicar el
  # identificador de la tabla (con o sin comillas). Por ejemplo:
  #  
  #   Entonces veo la tabla "bancales" con el siguiente contenido:
  #     | nombre    | área | longitud | latitud   |
  #     | Regadío-1 | 15   | N 41° 35 | W 003° 48 |
  #     | Regadío-2 | 42   | N 41° 35 | W 003° 48 |

    Dado que tenemos el huerto:
        | nombre   | área | longitud | latitud   | abono |
        | Secano-1 |   35 | N 40° 44 | W 003° 48 |       |
    Cuando visito la Página de Huertos
    #Entonces debería ver una tabla con el/los (siguiente/s)? contenido/s:
    Entonces debería ver una tabla con el siguiente contenido:
             | nombre   | área | longitud | latitud   | abono |
             | Secano-1 |   35 | N 40° 44 | W 003° 48 |       |
           Y debería ver una tabla con el contenido:
             | nombre   | área | longitud | latitud   | abono |
             | Secano-1 |   35 | N 40° 44 | W 003° 48 |       |
           Y debo ver una tabla con los siguientes contenidos:
             | nombre   | área | longitud | latitud   | abono |
             | Secano-1 |   35 | N 40° 44 | W 003° 48 |       |
           Y veo una tabla con el contenido:
             | nombre   | área | longitud | latitud   | abono |
             | Secano-1 |   35 | N 40° 44 | W 003° 48 |       |
           Y veo una tabla con el contenido:
             | nombre | área | longitud | latitud   | abono |
             | .*     |   35 | N 40° 44 | W 003° 48 |       |
    

  Escenario: Veo una tabla con un contenido concreto en sus celdas, utilizando el tag <tbody>
    Dado que tenemos los siguientes abonos:
        | nombre  | precio |
        | Abono 1 |     10 |
        | Abono 2 |     20 |
        | Abono 3 |     30 |
    Cuando visito la Página de Abonos
    Entonces debería ver una tabla con el siguiente contenido:
            | nombre  | precio |
            | Abono 1 |     10 |
            | Abono 2 |     20 |
            | Abono 3 |     30 |
  

  Escenario: Veo una tabla con un identificador concreto, por si hay varias tablas en una página

    Dado que tenemos los siguientes abonos:
        | nombre  | precio |
        | Abono 1 |     10 |
        | Abono 2 |     20 |
        | Abono 3 |     30 |
    Cuando visito la Página de Abonos
    Entonces debería ver la tabla "fertilizers" con el siguiente contenido:
            | nombre  | precio |
            | Abono 1 |     10 |
            | Abono 2 |     20 |
            | Abono 3 |     30 |
    Y debería ver la tabla shops con el siguiente contenido:
            | nombre  | 
            | Shop1   | 
            | Shop2   | 

  
