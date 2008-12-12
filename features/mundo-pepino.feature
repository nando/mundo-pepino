Característica: implementación de pasos genéricos
  Para escribir sólo la definición de los pasos específicos de mi proyecto
  Como usuario de Cucumber
  Quiero tener una serie de definiciones genéricas implementadas

##########################################################################
# Dado el contexto (Givens)
##########################################################################

  Escenario: Creación de uno o varios registros con un nombre opcional
  ########################################################################
  # Patrón: 
  #   Dado que hay _numero_ _modelo_( llamado _nombre_)
  #
  # Descripción:
  #   Nos crea una o más instancias de un modelo con la posibilidad de 
  #   asociar a las mismas un _nombre_ determinado.
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
    Entonces existen 14 huertos
           Y existe un huerto "En el río"
           Y existe una huerta "En el castro"
           Y existen 3 huertos "Regadío"
           Y existen 5 huertas "Secano"

##########################################################################
# Cuando algo ocurre (Whens)
##########################################################################

  Escenario: Solicitud de una URL específica opcionalmente indicada con un nombre coloquial
  ########################################################################
  # Patrón: 
  #   Cuando visito _url_o_nombre_
  #
  # Descripción:
  #   Solicita la URL referida comprobando previamente si el valor de la 
  #   misma ha sido mapeado en String.url_mappings.
  #
  # Ejemplos:
  #   Cuando visito /
  #   Cuando visito la portada
  ########################################################################
    Cuando visito /
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
    Cuando visito la portada
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
    Cuando visito la HOME
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"

  Escenario: Solicitud de la URL asociada al último recurso definido
  ########################################################################
  # Patrón: 
  #   Cuando visito su página
  #
  # Descripción:
  #   Solicita la ruta correspondiente al último recurso (instancia de AR 
  # en @resources) a partir de su mapeo en routes.rb 
  #
  # Ejemplo:
  #   Cuando visito su página
  #
  ########################################################################
    Dado que hay un huerto "Esplendoroso"
    Cuando visito su página
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Esplendoroso"


##########################################################################
# Entonces pasa (Thens)
##########################################################################

  Escenario: Tenemos una etiqueta HTML opcionalmente con un contenido concreto
  ########################################################################
  # Patrón: 
  #   Entonces (no) debo ver la etiqueta _selector_( con el valor "_valor_")
  #
  # Descripción:
  #   Comprueba la existencia o inexistencia de una etiqueta/selector que
  # opcionalmente debe tener un contenido concreto (case sensitive).
  #
  # Ejemplos:
  #  
  #     Entonces debo ver la etiqueta H1
  #     Entonces no debo ver la etiqueta div#title con el valor "Tomate"
  #
  ########################################################################
    Cuando visito la portada
    Entonces debo ver la etiqueta H1
    Entonces no debo ver la etiqueta HR
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
    Entonces no debo ver la etiqueta H1 con el valor "PORTADA DE MUNDO PEPINO"
    Entonces debo ver la etiqueta DIV#slogan con el valor "Todo un huerto para ti"
    Entonces no debo ver la etiqueta DIV#title con el valor "Todo un huerto para ti"
    
