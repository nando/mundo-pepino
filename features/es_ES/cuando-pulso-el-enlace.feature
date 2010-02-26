# language: es
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
    | pincho        |
    | pincho        |
    | pincho en     |
    | sigo          |
    | pulso         |
    | pulso en      |
    | hago click en |
         
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

  Esquema del escenario: Pincho en un enlace de creación de nuevo recurso
    Dado que visito la home
    Cuando pincho el enlace <a_la_pagina_de> nueva sesión
    Entonces debería encontrarme en la página de inicio de sesión
  Ejemplos:
    | a_la_pagina_de |
    | a la pagina de |
    |       de       |
    
  Esquema del escenario: Pincho en un enlace de edición de nuevo recurso
    Dado que tenemos un huerto llamado "Huerto One"
    Cuando visito la página de huertos
         Y pincho en el enlace <a_la_pagina_de> edición del huerto "Huerto One"
    Entonces debería encontrarme en la página de edición del "Huerto One"
  Ejemplos:
    | a_la_pagina_de |
    | a la pagina de |
    |       de       |

  Esquema del escenario: Pincho en un enlace de un recurso concreto o el último de un modelo
    Dado que tenemos un huerto llamado "Huerto One"
    Cuando visito /orchards
         Y pincho en el enlace <a_la_pagina_del> <huerto>
    Entonces debería encontrarme en la página del huerto "Huerto One"
  Ejemplos:
    | a_la_pagina_del   | huerto              |
    | a la página del   | huerto "Huerto One" |
    | a la página de la | huerto "Huerto One" |  
    | del               | huerto "Huerto One" |
    | de la             | huerto "Huerto One" |
    | a la página de    | dicho huerto        |

  Escenario: Pincho en el enlace del último recurso mencionado
    Dado que tenemos un huerto llamado "Huerto One"
       Y que visito /orchards
    Cuando pincho en el enlace a su página
    Entonces debería encontrarme en la página del huerto "Huerto One"

  Esquema del escenario: Pincho en un enlace al índice/listado de un modelo
    Dado que visito la portada
    Cuando pincho en el enlace <al_listado> de huertos
    Entonces debería estar en la página de huertos
  Ejemplos:
    | al_listado  |
    | al listado  |
    | a la página |

  Esquema del escenario: Pincho en un enlace al que nos referimos utilizando su ruta/url
    Dado que visito la portada
    Cuando pincho en el enlace <path>
    Entonces debería estar en <path>
  Ejemplos:
     | path                 |
     | /orchards            |
     | la página de registro|
   
  Escenario: Pincho en el enlace a la siguiente/anterior página
    Dado que visito la home
    Cuando pincho el enlace a la siguiente página
    Entonces no debería ver el enlace a la página siguiente
           Y debería ver el enlace a la página anterior
    Cuando pincho el enlace a la página anterior
    Entonces debería ver el enlace a la página siguiente
           Y no debería ver el enlace a la página anterior
