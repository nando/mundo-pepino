Característica: selector con jerarquía opcionalmente con un contenido

  Escenario: Veo (o no) un selector opcionalmente con un contenido concreto 
  ########################################################################
  # Patrón: 
  #   Entonces (no) debo ver el selector "_selector_"( con el valor "_valor_")
  # o:
  #   Entonces (no) debo ver en el selector "_selector_"( el valor "_valor_")
  # o:
  #   Entonces (no) veo el selector "_selector_"( con el valor "_valor_")
  #
  # Descripción:
  #   Comprueba la existencia o inexistencia de un selector que opcionalmente 
  # debe tener un contenido concreto (idéntica la definición "veo una 
  # etiqueta pero forzando al uso de comillas en el selector para poder
  # expresar una jerarquía).
  # 
  #   La etiqueta puede contener más texto alrededor de _valor_ pero dicho
  # texto es sensible a mayúsculas.
  #
  #   Tanto el _selector_ como el _valor_ deben ir entrecomillados.
  #
  # Ejemplos:
  #  
  #     Entonces debo ver el selector "ul li a.edit"
  #     Entonces debo ver el selector "ul li a.edit" con el valor "Editar"
  #
  ########################################################################
    Cuando visito la portada
    Entonces debo ver el selector "div label[for=login]"
    Entonces debo ver el selector "div label[for=login]" con el valor "Nombre de usuario"
