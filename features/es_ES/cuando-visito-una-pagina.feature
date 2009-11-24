Característica: Solicitud de una página ("cuando visito" o "dado que estoy en") 

  Esquema del escenario: Carga de URL específica opcionalmente indicada con un nombre coloquial
  ########################################################################
  # Patrón: 
  #   Cuando visito _pagina_
  #   Dado que estoy en _pagina_
  #
  # Descripción:
  #   Solicita la URL referida comprobando previamente si el valor de la 
  # misma ha sido mapeado en config.url_mappings.
  #
  #   El valor por defecto definido en el mapeo de URLs (string.to_url) 
  # devuelve la propia cadena si no existe un mapeo concreto para ella y 
  # comienza por / o https?://. En caso contrario devuelve nulo.
  #
  # Ejemplos:
  #
  #     Cuando visito /mi-pagina
  #
  #   Sería equivalente a tener definido el siguente mapeo:
  #
  #     MundoPepino.configure do |config|
  #       config.url_mappings[/mi página$/i] = '/mi-pagina'
  #     end
  #
  #   y escribir:
  #
  #     Cuando visito mi página
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
    Cuando <visito> <pagina>
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
  Ejemplos:
    | visito | pagina       |
    | visito | /            |
    | voy a  | /            |
    | visito | "/"          |
    | voy a  | "/"          |
    | visito | la portada   |
    | voy a  | "la portada" |

  Esquema del escenario: Solicitud de una URL específica en desde un "Given"
    Dado que <visito> <pagina>
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
  Ejemplos:
    | visito    | pagina     |
    | visito    | /          |
    | visito    | la portada |
    | estoy en  | /          |
    | estoy en  | la portada |

  Escenario: Solicitud de la URL asociada a la creación de un recurso
  ########################################################################
  # Patrón: 
  #   Cuando visito la página de creación de _modelo_
  # o:
  #   Cuando visito la página de nuevo/a _modelo_
  # o:
  #   Cuando visito la página de alta de _modelo_
  #
  # Descripción:
  #   Solicita la ruta correspondiente al formulario de alta de un 
  # recurso a partir del mapeo de su modelo en routes.rb 
  #
  # Ejemplos:
  #   Cuando visito la página de alta de Huerto
  #   Cuando visito la página de nuevo Huerto
  #
  ########################################################################
    Cuando visito la página de creación de huerto
    Entonces debo ver la etiqueta H2 con el valor "Alta de Huerta"
    Cuando visito la página de alta de huerto
    Entonces debo ver la etiqueta H2 con el valor "Alta de Huerta"
    Cuando visito la página de nueva huerta
    Entonces debo ver la etiqueta H2 con el valor "Alta de Huerta"

    Dado que visito la página de creación de huerto
    Entonces debo ver la etiqueta H2 con el valor "Alta de Huerta"

  Escenario: Solicitud de la URL asociada a la edición de un recurso
  ########################################################################
  # Patrón: 
  #   Cuando visito la página de edición del/de la _modelo_ "_nombre_"
  # o:
  #   Cuando visito la página de edición de "_nombre_"
  #
  # Descripción:
  #   Solicita la ruta correspondiente al formulario de edición de un 
  # recurso a partir del mapeo de su modelo en routes.rb
  #
  #   Si no encuentra dicho recurso lanza la excepción ResourceNotFound.
  # 
  #   En lugar de "edición" también están definidos como mapeos de acción
  # "edit" los "modificación" y "modificaciones".
  #
  # Ejemplos:
  #   Cuando visito la página de edición de la huerta "Regadío"
  #   Cuando visito la página de edición de "Regadío"
  #
  ########################################################################
    Dado que tenemos un huerto "Regadío"
    Cuando visito la página de edición del huerto "Regadío"
         Y selecciono 20:30 como hora de comienzo de riego
         Y pincho en el botón "Guardar"
    Entonces debería ver la etiqueta span#riego-comienzo con el valor "20:30"

    Cuando visito la página de modificación de la huerta "Regadío"
         Y selecciono 0:30 como hora de comienzo de riego
         Y pincho en el botón "Guardar"
    Entonces debería ver la etiqueta span#riego-comienzo con el valor "0:30"

    Cuando visito la página de modificaciones de "Regadío"
         Y selecciono 8:00 como hora de comienzo de riego
         Y pincho en el botón "Guardar"
    Entonces debería ver la etiqueta span#riego-comienzo con el valor "8:00"

  Escenario: Solicitud del índice de un tipo de recurso (index)
  ########################################################################
  # Patrón: 
  #   Cuando visito el/la página/portada/coleccion/listado/índice de _modelo_
  #
  # Descripción:
  #   Solicita la ruta correspondiente al formulario de alta de un 
  # recurso a partir del mapeo de su modelo en routes.rb 
  #
  # Ejemplos:
  #   Cuando visito la página de Huertos
  #   Cuando visito la portada de Huertos
  #
  ########################################################################
    Cuando visito la Página de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"

    Cuando visito la portada de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"

    Cuando visito la colección de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"

    Cuando visito el listado de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"

    Cuando visito el índice de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"


  Escenario: Solicitud de la URL asociada un recurso del que se facilita su nombre
  ########################################################################
  # Patrón: 
  #   Cuando visito la página del _modelo_ "_nombre_"
  #
  # Descripción:
  #   Solicita la ruta correspondiente a un recurso (instancia de AR 
  # en @resources) del cual se facilita su modelo y su nombre. 
  #
  # Ejemplo:
  #   Cuando visito la página del huerto "H-01"
  #
  ########################################################################
    Dado que tenemos dos huertos "Esplendoroso y Mermada"
    Cuando visito la página del huerto "Esplendoroso"
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Esplendoroso"
    Cuando visito la página de la huerta "Mermada"
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Mermada"

  Escenario: Solicitud de la URL asociada al último recurso definido de un modelo determinado
  ########################################################################
  # Patrón: 
  #   Cuando visito la página de dicha lechuga
  #
  ########################################################################
    Dado que tenemos un huerto "Esplendoroso"
    Cuando visito la página de dicha huerta
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Esplendoroso"

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
    Dado que tenemos un huerto "Esplendoroso"
    Cuando visito su página
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Esplendoroso"

    Dado que tenemos un huerto "Mermado"
       Y que visito su página
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Mermado"
  
  Escenario: visito una pagina relativa a otra visitada con anterioridad
    Dado que visito la portada
    Entonces veo un enlace a la siguiente página
           Y visito la página siguiente
           Y no veo un enlace a la siguiente página
           Y veo un enlace a la página anterior
           Y visito la página anterior
           Y no veo un enlace a la anterior página
           Y veo un enlace a la siguiente página

