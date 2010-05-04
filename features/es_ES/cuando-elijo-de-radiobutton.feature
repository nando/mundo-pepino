# language: es
Característica: elijo radiobutton

  Escenario: Elijo una opción de un radiobutton 
  ########################################################################
  # Patrón: 
  #   Cuando elijo _texto_de_label_
  # O:
  #   Cuando elijo (el/la/como)? _campo_ "_valor_"
  #
  # Ejemplos con texto de label asociada:
  #   Cuando elijo "Verde"
  #   Cuando elijo Pakistaní
  #
  # Ejemplos con composición de id a partir de campo y valor:
  #   Cuando elijo el color "VERDE"
  #   Cuando elijo como color "verde"
  #   Cuando elijo la nacionalidad "Pakistaní"
  #
  # Descripción:
  #   Selecciona un radio button por medio de una label o componiendo
  # su id a partir del nombre del campo y su valor.
  #
  #   Para localizar la opción combina ambos valores de forma similar
  # a como hace el helper de Rails radio_button_tag para construir su ID.
  # Por un lado _campo_:
  #   - Es convierte a un nombre de campo de nuestra app (con to_field)
  # Por otro _valor_:
  #   - Lo pasa a minúsculas,
  #   - Y sustituye los espacios por guiones bajos ("_").
  # Finalmente concatena ambos valores con un guión bajo:
  #   _campo_.to_field + '_' + _valor_.downcase.to_underscored
  #
  ########################################################################
    Cuando visito la portada
         Y elijo la nacionalidad "Pakistaní"
         Y pincho el botón "Galleta de la Fortuna"
    Entonces veo el tag div#nationality con el valor "Pakistaní"

  Esquema del escenario: Facilitando sólo el nombre del valor
    Cuando visito la portada
         Y elijo "<color>"
         Y pincho el botón "Galleta de la Fortuna"
    Entonces veo el tag div#color con el valor "verde"
  Ejemplos:
    | color            |
    | verde            |
    | app.colors.green |
    
  Escenario: Elijo una opción de un radiobutton (desde Given) 
    Dado que visito la portada
       Y que elijo como color "VERDE"
    Cuando pincho el botón "Galleta de la Fortuna"
    Entonces veo el tag div#color con el valor "verde"
