Característica: Creación simple

  Escenario: Creación de uno o varios recursos con un nombre opcional
  ########################################################################
  # Patrón: 
  #   Dado (que tenemos)? _numero_ _modelo_( llamado _nombre_)
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
  #   Si optamos por no escribir "que tenemos" hay que tener en cuenta
  #   que la frase será correcta sólo en aquellas frases que comiencen con
  #   "Y" o, si comienzan con "Dado" haga referencia a una instancia de 
  #   género másculino (p.e. "Dado un huerto:")
  #
  #   Por ejemplo:
  #
  #     String.field_mappings[:nombre] = 'title'
  #
  #   haría que dichas asignaciones se llevasen a cabo sobre el campo
  #   "title" en lugar de sobre "name".
  #
  # Ejemplos:
  #   Dado que tenemos 30 etiquetas
  #   Dado que tenemos un producto llamado "Acelga"
  #
  ########################################################################
    Dado que tenemos un huerto
       Y una huerta
       Y un huerto "En el río"
       Y una huerta "En el castro"
       Y un huerto llamado "Regadío"
       Y una huerta llamada "Secano"
       Y 2 huertos
       Y 2 huertos "Regadío"
       Y 2 huertos llamados "Secano"
       Y 2 huertas llamadas "Secano"
       Y 3 huertas llamadas "H-01, H-02 y H-03"
    Entonces tenemos en bbdd 17 huertos
           Y tenemos en bbdd un huerto "En el río"
           Y tenemos en bbdd una huerta "En el castro"
           Y tenemos en bbdd 3 huertos "Regadío"
           Y tenemos en bbdd 5 huertas "Secano"
           Y tenemos en bbdd un huerto "H-01"
           Y tenemos en bbdd un huerto "H-02"
           Y tenemos en bbdd un huerto "H-03"
