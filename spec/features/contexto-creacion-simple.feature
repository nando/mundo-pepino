Característica: Creación simple

  Escenario: Creación de uno o varios recursos con un nombre opcional
  ########################################################################
  # Patrón: 
  #   Dado que hay _numero_ _modelo_( llamado _nombre_)
  #
  # Descripción:
  #   Nos crea una o más instancias de un modelo con la posibilidad de 
  #   asociar a las mismas un _nombre_ determinado.
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
  #   Por ejemplo:
  #
  #     String.field_mappings[:nombre] = 'title'
  #
  #   haría que dichas asignaciones se llevasen a cabo sobre el campo
  #   "title" en lugar de sobre "name".
  #
  # Ejemplos:
  #   Dado que hay 30 tags
  #   Dado que hay un producto llamado "Acelga"
  #
  ########################################################################
    Dado que hay un huerto
       Y que hay una huerta
       Y que hay un huerto "En el río"
       Y que hay una huerta "En el castro"
       Y que hay un huerto llamado "Regadío"
       Y que hay una huerta llamada "Secano"
       Y que hay 2 huertos
       Y que hay 2 huertos "Regadío"
       Y que hay 2 huertos llamados "Secano"
       Y que hay 2 huertas llamadas "Secano"
       Y que hay 3 huertas llamadas "H-01, H-02 y H-03"
    Entonces existen 17 huertos
           Y existe un huerto "En el río"
           Y existe una huerta "En el castro"
           Y existen 3 huertos "Regadío"
           Y existen 5 huertas "Secano"
           Y existe un huerto "H-01"
           Y existe un huerto "H-02"
           Y existe un huerto "H-03"
