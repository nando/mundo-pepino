Característica: asignación de valores para un campo has_many polimórfico

  Escenario: Asignación de valores para un campo has_many polimórfico
  ########################################################################
  # Patrón: 
  #   Dado que dicho/a _mod_padre_ tiene el/la/los/las siguiente/s _mod_hijo_:
  #     | campo1 | campo2 |  ...  | campoN |
  #     | v1-1   | v2-2   |  ...  | v2-N   |
  #         .        .       ...      .
  #         .        .       ...      .
  #         .        .       ...      .
  #     | vN-1   | vN-2   |  ...  | vN-N   |
  #
  # Ejemplo:
  #   Dado que dicho huerto tiene los siguientes aspersores:
  #     | nombre | caudal | unidad caudal |
  #     |  A-01  |    15  | m3            |
  #     |  A-02  |    12  | m3            |
  #     |  B-01  |    10  | m3            |
  #
  # Descripción:
  #     Crea una instancia de _mod_hijo_ para cada fila de la step-table
  #   asociándolas al último recurso mencionado cuyo modelo sea _mod_padre_
  # 
  #     De forma similar a la asignación de valores a un recurso desde
  #   una step-table, si el nombre de un campo de la step-table está 
  #   mapeado con un modelo, buscará o creará una instancia cuyo nombre
  #   sea el valor facilitado (nieto) para proceder a su asociación con 
  #   el hijo correspondiente a esa fila de la tabla.
  #
  #   Ejemplo de mapeo de modelo:
  #
  #     String.model_mappings[/bancal(es)?$/i] = Terrace
  #
  ########################################################################
    Dado que tenemos un huerto llamado "H-01"
       Y que dicho huerto tiene los siguientes aspersores: 
       | nombre | caudal | unidad caudal |
       |  A-01  |    15  | m3            |
       |  A-02  |    12  | m3            |
       |  B-01  |    10  | m3            |
    Entonces tenemos en bbdd un huerto
           Y tenemos en bbdd tres aspersores
           Y el huerto "H-01" tiene en bbdd un aspersor "A-01"
           Y el aspersor "A-01" tiene en bbdd como caudal "15"
           Y tiene en bbdd como unidad caudal "m3"
           Y el huerto "H-01" tiene en bbdd un aspersor "A-02"
           Y el aspersor "A-02" tiene en bbdd como caudal "12"
           Y tiene en bbdd como unidad caudal "m3"
           Y el huerto "H-01" tiene en bbdd un aspersor "B-01"
           Y el aspersor "B-01" tiene en bbdd como caudal "10"
           Y tiene en bbdd como unidad caudal "m3"
