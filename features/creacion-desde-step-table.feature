Característica: creación desde step-table

  Escenario: Creación de uno o varios recursos a partir de una "step table"
  ########################################################################
  # Patrón: 
  #   Dado la/el/las/los siguiente/s _modelo_:
  #     | campo1 | campo2 |  ...  | campoN |
  #     | v1-1   | v2-2   |  ...  | v2-N   |
  #         .        .       ...      .
  #         .        .       ...      .
  #         .        .       ...      .
  #     | vN-1   | vN-2   |  ...  | vN-N   |
  #
  # Descripción:
  #     Nos crea una o más instancias de un modelo a partir de los datos
  #   existentes en una "step table".
  #
  ########################################################################
    Dado el siguiente huerto:
           | nombre   | área | latitud  | latitud   | abono   |
           | Secano   | 35   | N 40° 44 | W 003° 48 | FSF-315 |
       Y las siguientes huertas:
           | nombre    | área | latitud  | latitud   |
           | Regadío-1 | 15   | N 41° 35 | W 003° 48 |
           | Regadío-2 | 42   | N 41° 35 | W 003° 48 |
       Y que dichos huertos tienen como abono "HDR-102"
    Entonces existen 3 huertos
           Y el huerto "Secano" tiene como área "35"
           Y como abono "FSF-315"
           Y el huerto "Regadío-1" tiene como área "15"
           Y como abono "HDR-102"
           Y el huerto "Regadío-2" tiene como área "42"
           Y como abono "HDR-102"

