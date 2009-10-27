Característica: asignación de valores para un campo has_many polimórfico de un recurso concreto

  Escenario: Asignación de valores para un campo has_many polimórfico de un recurso concreto
  ########################################################################
  # Patrón: 
  #   Dado el/la _mod_padre_ _nombre_del_padre_ tiene el/la/los/las siguiente/s _mod_hijo_:
  #     | campo1 | campo2 |  ...  | campoN |
  #     | v1-1   | v2-2   |  ...  | v2-N   |
  #         .        .       ...      .
  #         .        .       ...      .
  #         .        .       ...      .
  #     | vN-1   | vN-2   |  ...  | vN-N   |
  #
  # Ejemplo:
  #   Dado que el huerto "H-01" tiene los siguientes aspersores:
  #     | nombre | caudal | unidad caudal |
  #     |  A-01  |    15  | m3            |
  #     |  A-02  |    12  | m3            |
  #     |  B-01  |    10  | m3            |
  #
  # Descripción:
  #     Crea una instancia de _mod_hijo_ para cada fila de la step-table
  #   asociándolas al recurso cuyo modelo sea _mod_padre_ y cuyo nombre
  #   sea _nombre_del_padre_.
  # 
  #     De forma similar a la asignación de valores a un recurso desde
  #   una step-table, si el nombre de un campo de la step-table está 
  #   mapeado con un modelo, buscará o creará una instancia cuyo nombre
  #   sea el valor facilitado (nieto) para proceder a su asociación con 
  #   el hijo correspondiente a esa fila de la tabla.
  #
  #   Ejemplo de mapeo de modelo:
  #     MundoPepino.configure do |config|
  #       config.model_mappings[/(abono|fertilizante)s?$/i] = Fertilizer
  #     end
  #
  ########################################################################
    Dado que tenemos dos huertos llamados "H-01 y H-02"
       Y que el huerto "H-01" tiene los siguientes aspersores: 
       | nombre | caudal | unidad caudal |
       |  A-01  |    15  | m3            |
       |  A-02  |    12  | m3            |
       |  B-01  |    10  | m3            |
       Y que el huerto "H-02" tiene los siguientes aspersores:
       | nombre | caudal | unidad caudal |
       |  C-01  |    15  | m3            |
       |  D-01  |    10  | m3            |
    Entonces tenemos en bbdd dos huertos
           Y tenemos en bbdd cinco aspersores
           Y el huerto "H-01" tiene en bbdd un aspersor "A-01"
           Y el aspersor "A-01" tiene en bbdd como caudal "15"
           Y tiene en bbdd como unidad caudal "m3"
           Y el huerto "H-01" tiene en bbdd un aspersor "A-02"
           Y el aspersor "A-02" tiene en bbdd como caudal "12"
           Y tiene en bbdd como unidad caudal "m3"
           Y el huerto "H-01" tiene en bbdd un aspersor "B-01"
           Y el aspersor "B-01" tiene en bbdd como caudal "10"
           Y tiene en bbdd como unidad caudal "m3"
           Y el huerto "H-02" tiene en bbdd un aspersor "C-01"
           Y tiene en bbdd un aspersor "D-01"
