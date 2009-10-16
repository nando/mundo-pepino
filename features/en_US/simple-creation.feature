Feature: Simple creation

  Scenario: Creation of one or more instances of a model with optional name/s
  ########################################################################
  # Syntax: 
  #   Given (that we have)? _number_ _modelo_( called _name_)
  #
  # Description:
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
    Given an orchard
      And one orchard
      And a tomatoe
      And a tomatoe "Red Tomatoe"
      And a tomatoe called "Dark Red Tomatoe"
      And 2 orchards
      And 2 orchards "Irrigated"
      And 2 orchards called "Unirrigated"
      And 3 orchards called "H-01, H-02 y H-03"
    Then we have 11 orchards in our database
#           Y tenemos en bbdd un huerto "En el río"
#           Y tenemos en bbdd una huerta "En el castro"
#           Y tenemos en bbdd 3 huertos "Regadío"
#           Y tenemos en bbdd 5 huertas "Secano"
#           Y tenemos en bbdd un huerto "H-01"
#           Y tenemos en bbdd un huerto "H-02"
#           Y tenemos en bbdd un huerto "H-03"
