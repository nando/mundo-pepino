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
       Y que dicho huerto tiene los siguientes bancales: 
       | nombre | longitud | cultivo |  matas |
       |  A-01  |    12    | Patatas |     16 |
       |  A-02  |    12    | Tomates |     28 |
       |  B-01  |    10    | Berzas  |     18 |
       Y que tenemos una huerta llamada "H-02"
       Y que dicha huerta tiene los siguientes bancales: 
       | nombre | longitud | cultivo |  matas |
       |  C-01  |    42    | Patatas |     38 |
    Entonces tenemos en bbdd 2 huertos
           Y tenemos en bbdd 4 bancales
           Y tenemos en bbdd 3 cultivos

           Y el huerto "H-01" tiene en bbdd un bancal "A-01"
           Y el bancal "A-01" tiene en bbdd como cultivo "Patatas"
           Y tiene en bbdd como longitud "12" metros
           Y tiene en bbdd como matas "16"
           Y el huerto "H-01" tiene en bbdd un bancal "A-02"
           Y el bancal "A-02" tiene en bbdd como cultivo "Tomates"
           Y tiene en bbdd como longitud "12" metros
           Y tiene en bbdd como matas "28"
           Y el huerto "H-01" tiene en bbdd un bancal "B-01"
           Y el bancal "B-01" tiene en bbdd como cultivo "Berzas"
           Y tiene en bbdd como longitud "10" metros
           Y el bancal "B-01" tiene en bbdd como matas "18"

           Y la huerta "H-02" tiene en bbdd un bancal "C-01"
