Característica: debería estar en una URL específica

  Escenario: Debería estar en una URL específica op. indicada con un nombre coloquial
  ########################################################################
  # Patrón: 
  #   Entonces debería|debo estar|encontrarme en _pagina_
  #
  # Descripción:
  #   Comprueba que nos encontramos en _pagina_ comprobando previamente
  # si el valor de la misma ha sido mapeado en config.url_mappings.
  #
  #   Si se ha definido una función "path_to" los mapeos de url_mappings
  # son ignorados y se utilizará dicha función para obtener la ruta que
  # se debe comprobar.
  #
  #   El valor por defecto definido en el mapeo de URLs (string.to_url) 
  # devuelve la propia cadena si no existe un mapeo concreto para ella y 
  # comienza por / o https?://. En caso contrario devuelve nulo.
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
