Característica: solicitud de URL específica

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
    Cuando visito "/"
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
    Cuando visito la portada
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
    Cuando visito "la HOME"
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"

  Escenario: Solicitud de una URL específica en definición de contexto "Given"
    Dado que visito la portada
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
