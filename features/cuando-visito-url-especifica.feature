Característica: solicitud de URL específica

  Escenario: Solicitud de una URL específica opcionalmente indicada con un nombre coloquial
  ########################################################################
  # Patrón: 
  #   Cuando visito _pagina_
  #
  # Descripción:
  #   Solicita la URL referida comprobando previamente si el valor de la 
  # misma ha sido mapeado en String.url_mappings.
  #
  #   El valor por defecto definido en el mapeo de URLs (string.to_url) 
  # devuelve la propia cadena si no existe un mapeo concreto para ella y 
  # comienza por / o https?://. En caso contrario devuelve nulo.
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
  #     Cuando visito La Home. 
  #
  #   Por otro lado:
  #
  #     Cuando visito /pilots/sully-iii
  #
  #   Nos llevaría a '/pilots/sully-iii' (si dicha cadena no tiene un 
  # mapeo a otro lugar, cosa bastante absurda por otro lado).
  # 
  #   Por último:
  #
  #     Cuando visito la entreplanta
  #
  #   ...nos devolverá nulo si 'la entreplanta' no tiene definido ningún 
  # mapeo de URL, o el valor de dicho mapeo en caso contrario.
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
