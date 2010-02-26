# language: es
Característica: Asignación en un campo has_many desde fit-tables

  Esquema del escenario: Asignación de campo has_many desde fit-table
  ########################################################################
  # Patrón: 
  #   Dado que el _mod_padre_ "_nombre_padre_" tiene el/la/los/las siguiente/s _mod_hijo_:
  # o:
  #   Dado que dicho/a _mod_padre_ tiene el/la/los/las siguiente/s _mod_hijo_:
  # seguido de:
  #     | campo1 | campo2 |  ...  | campoN |
  #     | v1-1   | v2-2   |  ...  | v2-N   |
  #         .        .       ...      .
  #         .        .       ...      .
  #         .        .       ...      .
  #     | vN-1   | vN-2   |  ...  | vN-N   |
  #
  # Ejemplo refiriéndonos a un recurso explícitamente:
  #
  #   Dado que el huerto "H-01" tiene los siguientes bancales:
  #     | nombre | longitud | cultivo |  matas |
  #     |  A-01  |    12    | Patatas |     16 |
  #     |  A-02  |    12    | Tomates |     18 |
  #     |  B-01  |    10    | Berzas  |     18 |
  #
  # Ejemplo haciendo referencia a un recurso mencionado: 
  #
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
  ########################################################################
    Dado que tenemos un huerto llamado "H-01"
       Y que <el_huerto_h1> tiene los siguientes bancales: 
       | nombre | longitud | cultivo |  matas |
       |  A-01  |    12    | Patatas |     16 |
       |  A-02  |    12    | Tomates |     28 |
       |  B-01  |    10    | Berzas  |     18 |
       Y que tenemos una huerta llamada "H-02"
       Y que <la_huerta_h2> tiene los siguientes bancales: 
       | nombre | longitud | cultivo |
       |  C-01  |    42    | Patatas |
       Y que el bancal "C-01" tiene como matas "38"
       Y que <el_bancal> tiene los siguientes pepinos:
       | nombre | diámetro | longitud |
       | pequeño|    4     |    11    |
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
           Y el bancal "C-01" tiene en bbdd un pepino "pequeño"
  Ejemplos:
    | el_huerto_h1      | la_huerta_h2      | el_bancal        |
    | dicho huerto      | dicha huerta      | dicho bancal     |
    | el huerto "H-01"  | la huerta "H-02"  | el bancal "C-01" |

  Esquema del escenario: Asignación en un campo has_many cuyo belongs_to asociado tiene un nombre que no coincide con el modelo
  # User has_many :sended_flowers, :class_name => Flower
  # Flower belongs_to :from, :class_name => User
    Dado que tenemos una usuaria llamada "Rosa"
       Y que <la_usuaria> tiene las siguientes flores enviadas:
         | título    |
         | Clavel    |
         | Margarita |
         | Orquídea  |
    Entonces la usuaria "Rosa" tiene en bbdd tres flores enviadas
    Entonces la usuaria "Rosa" tiene en bbdd una flor enviada "Clavel"
           Y tiene en bbdd una flor enviada "Margarita"
           Y tiene en bbdd una flor enviada "Orquídea"
           Y la flor "Clavel" tiene en bbdd como remitente "Rosa"
           Y la flor "Margarita" tiene en bbdd como remitente "Rosa"
           Y la flor "Orquídea" tiene en bbdd como remitente "Rosa"
  Ejemplos:
    | la_usuaria        |
    | dicha usuaria     |
    | la usuaria "Rosa" |
