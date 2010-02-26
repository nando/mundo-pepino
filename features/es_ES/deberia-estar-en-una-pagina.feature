# language: es
Característica: Debería encontrarme en una página de mi sitio

  Escenario: Debería estar en una URL específica op. indicada con un nombre coloquial
  ########################################################################
  # Patrón: 
  #   Entonces debería|debo estar|encontrarme en _pagina_
  #
  # Descripción:
  #   Comprueba que nos encontramos en _pagina_ comprobando previamente
  # si el valor de la misma ha sido mapeado en config.url_mappings.
  #
  #   El valor por defecto definido en el mapeo de URLs devuelve la propia
  # cadena si no existe un mapeo concreto para ella y comienza por / o
  # https?://. En caso contrario devuelve nulo.
  #
  # Ejemplos:
  #
  #     Entonces debo estar en /mi-pagina
  #
  #   Sería equivalente a tener definido el siguente mapeo:
  #
  #     MundoPepino.configure do |config|
  #       config.url_mappings[/mi página$/i] = '/mi-pagina'
  #     end
  #
  #   y escribir:
  #
  #     Entonces debo estar en mi página
  #
  ########################################################################
    Dado que estoy en la portada
    Entonces debo estar en la portada
    Entonces debería estar en la portada
    Entonces deberia encontrarme en la portada

    Cuando pincho en el enlace "¡Entra!"
    Entonces debería encontrarme en la página de login
           Y debería encontrarme en la página de identificación
           Y debería encontrarme en la página de inicio de sesión

  Escenario: Debo estar en la página de creación de recurso
    Cuando visito la página de creación de huerto
    Entonces debo estar en la página de creación de huertos
           Y debo estar en la página de alta de huerto
           Y debo estar en la página de nueva huerta
           Y debo estar en la página de alta de nueva huerta
           Y debo estar en la página de alta de una nueva huerta
           Y debo estar en la página de creación de nuevo huerto
           Y debo estar en la página de creación de un nuevo huerto

  Escenario: Estoy en la página asociada a la edición de un recurso
    Dado que tenemos un huerto "Regadío"
    Cuando visito la página de edición del huerto "Regadío"
    Entonces debería estar en la página de edición del huerto "Regadío"
           Y debería estar en la página de modificación del huerto "Regadío"
           Y debería estar en la página de modificaciones del huerto "Regadío"

  Escenario: Debería estar en el índice de un tipo de recurso (index)
  ########################################################################
  # Patrón: 
  #   Debo estar en el/la página/portada/coleccion/listado/índice de _modelo_
  #   Debería encontrarme en la página de _modelo_
  ########################################################################
    Cuando visito la Página de Huertos
    Entonces debo estar en la Página de Huertos
    Entonces debería estar en la Página de Huertos
    Entonces deberia encontrarme en la Página de Huertos

  Escenario: Estoy en la página asociada un recurso del que se facilita su nombre
    Dado que tenemos dos huertos "Esplendoroso y Mermada"
    Cuando visito la página del huerto "Esplendoroso"
    Entonces debo estar en la página de la huerta "Esplendoroso"

  Escenario: Estoy en la página asociada al último recurso mencionado de un modelo concreto
    Dado que tenemos dos huertos "Esplendoroso y Mermada"
    Cuando visito la página del huerto "Esplendoroso"
    Entonces debo estar en la página de dicho huerto

  Escenario: Debería estar en la página de un recurso que ha sido mencionado
    Dado que tenemos un huerto "Esplendoroso"
    Cuando visito la página del huerto "Esplendoroso"
    Entonces debería estar en su página
           Y estoy en su portada
