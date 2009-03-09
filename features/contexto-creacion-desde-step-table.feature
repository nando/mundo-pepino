Característica: creación desde step-table

  Escenario: Creación de uno o varios recursos a partir de una "step table"
  ########################################################################
  # Patrón 1: 
  #   Dado (que tenemos)? la/el/las/los (siguiente/s)? _modelo_:
  #     | campo1 | campo2 |  ...  | campoN |
  #     | v1-1   | v2-2   |  ...  | v2-N   |
  #         .        .       ...      .
  #         .        .       ...      .
  #         .        .       ...      .
  #     | vN-1   | vN-2   |  ...  | vN-N   |
  # 
  # Descripción:
  #     Nos crea una o más instancias de un modelo a partir de los datos
  #   tenemos en bbddtes en una "step table".
  #
  #     Si el nombre de un campo de la step-table está mapeado con un 
  #   modelo, se buscará una instancia de dicho modelo cuyo "nombre" sea
  #   el valor facilitado. Si no existe creará una nueva instancia con 
  #   dicho valor.
  #
  #     Si optamos por no escribir "que tenemos" hay que tener en cuenta
  #   que la frase será correcta sólo en aquellas frases que comiencen con
  #   "Y" o, si comienzan con "Dado" haga referencia a una instancia de 
  #   género másculino (p.e. "Dado el huerto:")
  #
  ########################################################################
    Dado que tenemos el huerto:
           | nombre   | área | longitud | latitud   | abono   | cultivado |
           | Secano-1 | 35   | N 40° 44 | W 003° 48 | FSF-315 | verdadero |
       Y la huerta:
           | nombre   | área | longitud | latitud   | abono   | cultivado |
           | Secano-2 | 15   | N 41° 44 | W 002° 48 | FSF-317 | falso     |
       Y el siguiente huerto:
           | nombre   | área | longitud | latitud   | abono   | cultivado |
           | Secano-3 | 20   | N 42° 41 | W 004° 48 | FSF-319 | verdadero |
       Y las siguientes huertas:
           | nombre    | área | longitud | latitud   |
           | Regadío-1 | 15   | N 41° 35 | W 003° 48 |
           | Regadío-2 | 42   | N 41° 35 | W 003° 48 |
       Y que dichos huertos tienen como abono "HDR-102"
    Entonces tenemos en bbdd cinco huertos
           Y tenemos en bbdd cuatro fertilizantes
           Y el huerto "Secano-1" tiene en bbdd como abono "FSF-315"
           Y tiene en bbdd como cultivado "verdadero"
           Y el huerto "Secano-2" tiene en bbdd como abono "FSF-317"
           Y tiene en bbdd como cultivado "falso"
           Y el huerto "Secano-3" tiene en bbdd como abono "FSF-319"
           Y tiene en bbdd como cultivado "verdadero"
           Y el huerto "Regadío-1" tiene en bbdd como abono "HDR-102"
           Y tiene en bbdd como área "15" hectáreas
           Y el huerto "Regadío-2" tiene en bbdd como abono "HDR-102"
           Y tiene en bbdd como área "42" hectáreas

