Característica: veo enlace a URL relativo a la última visita realizada

  Escenario: Veo un enlace a una URL específica opcionalmente indicada con un nombre coloquial
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
