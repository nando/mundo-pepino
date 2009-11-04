Característica: veo enlace a URL específica

  Escenario: Veo un enlace a una URL específica opcionalmente indicada con un nombre coloquial
  ########################################################################
  # Patrón: 
  #   Entonces no? debería ver un enlace a _pagina_
  #   Entonces no? debo ver un enlace a _pagina_
  #   Entonces no? veo un enlace a _pagina_
  #   Entonces no? veo un enlace para _pagina_
  #
  # Descripción:
  #   Comprueba la presencia de un enlace a URL referida comprobando 
  # previamente si el valor de la misma ha sido mapeado (en 
  # config.url_mappings).
  #
  #   Si se ha definido una función "path_to" utilizará dicha función
  # para convertir el texto en la ruta que debe ser encontrada.
  #
  #   El valor por defecto definido en el mapeo de URLs (string.to_url) 
  # devuelve la propia cadena si no existe un mapeo concreto para ella y 
  # comienza por / o https?://. En caso contrario devuelve nulo.
  #
  # Ejemplos:
  #
  #     Entonces veo un enlace para finalizar mi sesión
  # 
  #   Otro:
  #
  #     Entonces veo un enlace a /mi-pagina
  #
  #   Sería equivalente a tener definido el siguente mapeo:
  #     MundoPepino.configure do |conf|
  #       conf.url_mappings[/mi página/i] = '/mi-pagina'
  #     end
  #
  #   y escribir:
  #
  #     Entonces veo un enlace a mi página
  #
  ########################################################################
    Cuando visito la portada
    Entonces veo un enlace a la página de registro
           Y debo ver un enlace a la página de registro
           Y debo ver un enlace para la página de registro
           Y debo ver un enlace a /welcome/signup
           Y debería ver un enlace a la página de registro
           Y debería ver un enlace a la página de inicio de sesión
           Y no debería ver un enlace a /welcome/goodbye

  Escenario: Veo un enlace a una URL específica cuyo mapeo utiliza Regexp
    Dado que tenemos un huerto "Fancy"
    Cuando visito la página de huertos
    Entonces debería ver un enlace a la página del huerto "Fancy"
