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
  # String.url_mappings).
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
  #     Entonces veo un enlace a /
  #
  #   Sería equivalente a tener definido el siguente mapeo:
  #
  #     String.url_mappings[/la (portada|home)/i] = '/'
  #
  #   y escribir:
  #
  #     Entonces veo un enlace a la portada
  #
  #   o:
  #
  #     Entonces veo un enlace a la home
  #
  ########################################################################
    Cuando visito /
    Entonces veo un enlace a la página de registro
           Y debo ver un enlace a la página de registro
           Y debo ver un enlace para la página de registro
           Y debo ver un enlace a /welcome/signup
           Y debería ver un enlace a la página de registro
           Y no debería ver un enlace a /welcome/goodbye
