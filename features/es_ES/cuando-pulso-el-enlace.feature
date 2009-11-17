Característica: pulso el enlace opcionalmente dentro de un selector

  Esquema del escenario: Pincho/pulso en un enlace/enlace
  ########################################################################
  # Patrón: 
  #   Cuando pincho/pulso (en)? el enlace _enlace_
  # o  
  #   Cuando pincho/pulso (en)? el enlace _enlace_ dentro de _selector_
  #
  # Ejemplos:
  #   Cuando pincho el enlace "registro"
  #   Cuando pulso en el enlace Home dentro de "div#navigation_links"
  #
  # Descripción:
  #   Carga la URL del enlace cuyo texto es _enlace_ que puede indicarse
  # con o sin comillas (simples o dobles).
  #
  ########################################################################
    Cuando visito la home
    Cuando <pincho> el enlace Registro
    Entonces veo la etiqueta H1 con el valor "Registro en Mundo Pepino"
    Cuando <pincho> el enlace "Volver"
    Entonces veo la etiqueta H1 con el valor "Portada de Mundo Pepino"
  Ejemplos:
    | pincho       |
    | pincho       |
    | pincho en    |
    | sigo         |
    | pulso        |
    | pulso en     |
         
  Esquema del escenario: Pincho en un enlace que se encuentra dentro de un selector
    Dado que visito la home
    Cuando pincho el enlace Registro <dentro_de> .navigation_links
    Entonces veo la etiqueta H1 con el valor "Registro en Mundo Pepino"
    Cuando pincho el enlace "Volver" <dentro_de> ".navigation_links"
    Entonces veo la etiqueta H1 con el valor "Portada de Mundo Pepino"
  Ejemplos:
       | dentro_de                        |
       | dentro de                        |
       | dentro del selector              |
       | dentro de la etiqueta            |
       | que hay dentro de                |
       | que existe dentro de             |
       | que hay dentro del selector      |
       | que existe dentro de la etiqueta |
     
  Escenario: Pincho en un enlace desde Given
    Dado que visito la home
       Y que pincho el enlace Registro
    Entonces veo la etiqueta H1 con el valor "Registro en Mundo Pepino"
    Dado que pincho el enlace "Volver" dentro de ".navigation_links"
    Entonces veo la etiqueta H1 con el valor "Portada de Mundo Pepino"

