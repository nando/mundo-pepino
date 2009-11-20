Característica: Comprobamos la existencia de un enlace en la página actual

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
           Y no debería ver un enlace a /welcome/goodbye

  Escenario: Veo un enlace a una URL específica cuyo mapeo utiliza Regexp
    Dado que tenemos un huerto "Fancy"
    Cuando visito la página de huertos
    Entonces debería ver un enlace a la página del huerto "Fancy"

  Escenario: Veo un enlace a la página asociada a la creación de un recurso
    Cuando visito la portada
    Entonces debería ver un enlace a la página de inicio de sesión
           Y debería ver un enlace a la página de nueva sesión

  Escenario: Veo un enlace a un listado de recursos
    Cuando visito la portada
    Entonces debería ver un enlace a la página de huertos

  Escenario: Veo un enlace a la página asociada a la edición de un recurso
    Dado que tenemos un huerto "Regadío Número 1"
    Cuando visito la página de huertos
    Entonces debería ver un enlace a la página de edición del huerto "Regadío Número 1"

  Escenario: Veo un enlace a la página de un recurso específico indicando su nombre
    Dado que tenemos un huerto "Regadío Número 1"
    Cuando visito la página de huertos
    Entonces debería ver un enlace a la página del huerto "Regadío Número 1"

  Escenario: Veo un enlace a la página de un recurso anteriormente mencionado
    Dado que tenemos un huerto "Regadío Número 1"
    Cuando visito /orchards
    Entonces debería ver un enlace a su página
           Y debería ver un enlace a su portada
  
  Escenario: Veo un enlace a una URL relativa a la última
  ########################################################################
  # Patrones: 
  #   Entonces no? debería ver un enlace a la siguente página
  #   Entonces no? debería ver un enlace a la página anterior
  #
  # Descripción:
  #   Busca en el HTML de la respuesta actual un enlace a una URL como la
  # última solicitada pero con el parámetro "page" incremetado o decremen-
  # tado. Si la última URL solicitada no tenía "page" buscará la segunda 
  # página ("/last?page=2").
  #
  ########################################################################
    Cuando visito /
    Entonces no veo un enlace a la página anterior
           Y veo un enlace a la siguiente página
    Cuando visito /?page=1
    Entonces no veo un enlace a la página anterior
           Y veo un enlace a la siguiente página

    Cuando visito /?page=2
    Entonces veo un enlace a la página anterior
           Y no veo un enlace a la siguiente página
