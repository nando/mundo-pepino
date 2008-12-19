Característica: asignación de valores para un campo has_many

  Escenario: Asignación de valores para un campo has_many
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
  #   Dado que dicho huerto tiene los siguientes bancales:
  #     | nombre | longitud | cultivo |  matas |
  #     |  A-01  |    12    | Patatas |     16 |
  #     |  A-02  |    12    | Tomates |     18 |
  #     |  B-01  |    10    | Berzas  |     18 |
  #
  # Descripción:
  #     Crea una instancia de _mod_hijo_ para cada fila de la step-table
  #   asociándolas a la último recurso mendionado de _mod_padre_
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
    Dado que hay un huerto llamado "H-01"
       Y que dicho huerto tiene los siguientes bancales: 
       | nombre | metros | cultivo |  matas |
       |  A-01  |    12  | Patatas |     16 |
       |  A-02  |    12  | Tomates |     28 |
       |  B-01  |    10  | Berzas  |     18 |
    Entonces existe un huerto
           Y tres bancales
           Y tres cultivos
           Y el huerto "H-01" tiene un bancal "A-01"
           Y el bancal "A-01" tiene como cultivo "Patatas"
           Y como metros "12"
           Y como matas "16"
           Y el huerto "H-01" tiene un bancal "A-02"
           Y el bancal "A-02" tiene como cultivo "Tomates"
           Y como metros "12"
           Y como matas "28"
           Y el huerto "H-01" tiene un bancal "B-01"
           Y el bancal "B-01" tiene como cultivo "Berzas"
           Y como metros "10"
           Y el bancal "B-01" tiene como matas "18"