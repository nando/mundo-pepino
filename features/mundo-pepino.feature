Característica: implementación de pasos genéricos
  Para escribir sólo la definición de los pasos específicos de mi proyecto
  Como usuario de Cucumber
  Quiero tener una serie de definiciones genéricas implementadas

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
    
