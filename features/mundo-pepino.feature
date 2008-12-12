Característica: implementación de pasos genéricos
  Para escribir sólo la definición de los pasos específicos de mi proyecto
  Como usuario de Cucumber
  Quiero tener una serie de definiciones genéricas implementadas

##########################################################################
# Dado el contexto (Givens)
##########################################################################

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

  Escenario: Asignación de un valor en un campo de los últimos recursos definidos
  ########################################################################
  # Patrón: 
  #   Dado que dicho/a (_modelo_)? tiene/n como _campo_ "_valor_" (_unidades_)?
  #
  # Ejemplos:
  #   Dado que dicho huerto tiene como área "25" hectáreas
  #   Dado que dichas huertas tienen como abono "Nitrogenado de 1ª calidad"
  #
  # Descripción:
  #     Asigna un _valor_ a un _campo_ del último o últimos recursos definidos
  #   del _modelo_ mencionado
  #
  #     Dicha asignación se llevará a cabo de acuerdo con lo siguiente:
  #
  #   - Si _campo_ está mapeado con un modelo el valor será el registro de 
  #     dicho modelo cuyo nombre sea _valor_, creándolo si no existe aún.
  #
  #   - En caso contrario se asignará directamente _valor_ a _campo_.to_field 
  #
  #   Ejemplo de mapeo de campo:
  #
  #     String.field_mappings[/[áa]rea/i] = 'area'
  #
  #   Ejemplo de mapeo de modelo:
  #
  #     String.model_mappings[/(abono|fertilizante)s?$/i] = Fertilizer
  #
  ########################################################################
    Dado que hay un huerto llamado "H-01"
       Y que dicho huerto tiene como área "60" hectáreas
       Y que dicho huerto tiene como latitud "N 40° 44,340"
       Y que dicho huerto tiene como longitud "W 003° 48,730"
  #     Y que dicho huerto tiene como abono "Nitrogenado de 2ª calidad"
  #     Y que hay tres huertos llamados "H-02, H-03 y H-04"
    Entonces el huerto "H-01" tiene como área "60"
           Y como latitud "N 40° 44,340"
           Y como longitud "W 003° 48,730"
  #         Y como abono "Nitrogenado de 2ª calidad"

##########################################################################
# Cuando algo ocurre (Whens)
##########################################################################

  Escenario: Solicitud de una URL específica opcionalmente indicada con un nombre coloquial
  ########################################################################
  # Patrón: 
  #   Cuando visito _pagina_
  #
  # Descripción:
  #   Solicita la URL referida comprobando previamente si el valor de la 
  #   misma ha sido mapeado en String.url_mappings.
  #
  # Ejemplos:
  #
  #     Cuando visito /
  #
  #   Sería equivalente a tener definido el siguente mapeo:
  #
  #     String.url_mappings[/la (portada|home)/i] = '/'
  #
  #   y escribir:
  #
  #     Cuando visito la portada
  #
  #   o:
  #
  #     Cuando visito La Home
  #
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
    
