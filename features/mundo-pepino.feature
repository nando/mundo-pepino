Característica: implementación de pasos genéricos
  Para escribir sólo la definición de los pasos específicos de mi proyecto
  Como usuario de Cucumber
  Quiero tener una serie de definiciones genéricas implementadas

  ########################################################################
  # Patrón: Dado que hay _numero_ _modelo_( llamado _nombre_)
  # Descripción:
  #   Nos crea una o más instancias de un modelo con la posibilidad de 
  #   asociar a las mismas un _nombre_ determinado.
  #
  #   Dicha asignación se llevará a cabo sobre el campo "name" si no se
  #   indica lo contrario mapeando "nombre" en String.field_mappings.
  #   Por ejemplo:
  #
  #     String.field_mappings[:nombre] = 'title'
  #
  #   haría que dichas asignaciones se llevasen a cabo sobre el campo
  #   "title" en lugar de sobre "name".
  ########################################################################
  Escenario: Creación de uno o varios registros con un nombre opcional
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
    Entonces existen 14 huertos
           Y existe un huerto "En el río"
           Y existe una huerta "En el castro"
           Y existen 3 huertos "Regadío"
           Y existen 5 huertas "Secano"
