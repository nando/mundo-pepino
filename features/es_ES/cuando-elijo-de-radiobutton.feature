Característica: elijo radiobutton

  Escenario: Elijo una opción de un radiobutton 
  ########################################################################
  # Patrón: 
  #   Cuando elijo (el/la)? _campo_ "_valor_"
  #
  # Ejemplos:
  #   Cuando elijo color "verde"
  #   Cuando elijo el color "VERDE"
  #   Cuando elijo la nacionalidad "Pakistaní"
  #
  # Descripción:
  #   Selecciona la opción _valor_ del radio button _campo_.  
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
         Y pincho el botón "Galleta de la fortuna"
    Entonces veo el tag div#nationality con el valor "Pakistaní"
    
    Cuando visito la portada
         Y elijo Color "VERDE"
         Y pincho el botón "Galleta de la fortuna"
    Entonces veo el tag div#color con el valor "verde"
    
  Escenario: Elijo una opción de un radiobutton (desde Given) 
    Dado que visito la portada
       Y que elijo Color "VERDE"
    Cuando pincho el botón "Galleta de la fortuna"
    Entonces veo el tag div#color con el valor "verde"
