Característica: pulso el enlace

  Escenario: Pincho/pulso en un enlace/enlace ajax/enlace con efectos
  ########################################################################
  # Patrón: 
  #   Cuando pincho/pulso (en)? el enlace/ _enlace_
  #
  # Ejemplos:
  #   Cuando pincho el enlace "registro"
  #   Cuando pulso en el enlace Home
  #
  # Descripción:
  #   Carga la URL del enlace cuyo texto es _enlace_ que puede indicarse
  # con o sin comillas (simples o dobles).
  #
  ########################################################################
    Cuando visito la home
    Entonces veo la etiqueta H1 con el valor "Portada de Mundo Pepino"
    Cuando pincho en el enlace Registro
    Entonces veo la etiqueta H1 con el valor "Registro en Mundo Pepino"
    Cuando pulso el enlace "Volver"
    Entonces veo la etiqueta H1 con el valor "Portada de Mundo Pepino"
         
  Escenario: Pincho en un enlace desde Given
    Dado que visito la home
       Y que pincho el enlace Registro
    Entonces veo la etiqueta H1 con el valor "Registro en Mundo Pepino"
