Característica: Creación de recurso/s con un valor en alguno de sus campos
  ########################################################################
  # Patrón: 
  #   Dado (que tenemos)? _n_ _modelo_ cuyo/a _campo_ es de? "_valor_" _uds_?
  #   Dado (que tenemos)? _n_ _modelo_ que tiene como _campo_ "_valor_" _uds_?
  #
  # Descripción:
  #   Nos crea _n_ instancias de _modelo_ asignándole/s _valor_ en _campo_.
  #   
  #   Si _campo_ está mapeado con algún modelo interpreta que se trata de 
  #   una relacción *belongs_to* con el mismo. En este caso buscará alguna
  #   instancia de dicho modelo _campo_ cuyo nombre sea _valor_ para 
  #   realizar la asociación, creándola si no existiese.
  #
  #   Podemos terminar la frase con las unidades _uds_ de dicho _valor_
  #   (el contenido de dicha terminación _uds_ será ignorado).
  # 
  #   Si se solicita la creación de más de una instancia es posible de
  #   asignar un nombre distinto a cada una separándolos en _nombre_ con
  #   con "," o "y". Si _nombre_ no contiene comas o el número de partes
  #   resultantes no coincide con _numero_, _nombre_ será asignado a
  #   todas las instancias.
  #
  #   Dicha asignación se llevará a cabo sobre el campo "name" si no se
  #   indica lo contrario mapeando "nombre" en String.field_mappings.
  #
  # Ejemplos:
  #   Dado que tenemos un producto cuyo tipo es "Acelga"
  #
  ########################################################################
  Escenario: Creación de un recurso asignándole un valor en un campo normal
    Dado que tenemos un huerto cuya área es de "59" metros cuadrados
    Entonces tenemos en bbdd un huerto
           Y tiene en bbdd como área "59"

  Escenario: Creación de un recurso asignándole un valor en un campo de relación
    Dado que tenemos un bancal que tiene como huerto "Acelgas y tomates"
       Y que dicho bancal tiene como nombre "Primero"
       Y que tenemos una acelga que tiene como bancal "Primero"
    Entonces tenemos en bbdd una acelga
           Y tiene en bbdd como bancal "Primero"
           Y tenemos en bbdd un bancal llamado "Primero"
           Y tiene en bbdd como huerto "Acelgas y tomates"
           
  Escenario: Creación de dos recursos asignándoles valores distintos
    Dado que tenemos dos huertos cuyas áreas son "12 y 14" metros cuadrados respectivamente
       Y que dichos huertos tienen como nombre "A y B"
    Entonces tenemos en bbdd dos huertos
           Y el huerto "A" tiene en base de datos como área "12"
           Y el huerto "B" tiene en base de datos como área "14"

  Escenario: Creación de dos recursos asignándoles el mismo valor
    Dado que tenemos dos huertos cuyas áreas son "12" metros cuadrados
       Y que dichos huertos tienen como nombre "A y B"
    Entonces tenemos en bbdd dos huertos
           Y el huerto "A" tiene en base de datos como área "12"
           Y el huerto "B" tiene en base de datos como área "12"

  Escenario: Con nombre de relacion que no se corresponde con su modelo asociado
    Dado que tenemos un huerto llamado "de secano"
       Y que tenemos una lechuga "seca"
       Y que dicha lechuga tiene como huerto de nacimiento "de secano"
    Entonces tenemos en bbdd un huerto
           Y tenemos en bbdd una lechuga
           Y la lechuga "seca" tiene en bbdd como huerto de nacimiento "de secano"
