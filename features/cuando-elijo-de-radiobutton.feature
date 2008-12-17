Característica: elijo radiobutton

  Escenario: Elijo una opción de un radiobutton 
  ########################################################################
  # Patrón: 
  #   Cuando elijo (el/la)? _radio_id_
  #
  # Ejemplos:
  #   Cuando elijo color_verde
  #   Cuando elijo "COLOR VERDE"
  #   Cuando elijo la nacionalidad Pakistaní
  #
  # Descripción:
  #   Selecciona el radio button con el identificador indicado admitiendo
  # comillas opcionales. 
  # 
  #   Además sobre el identificador facilitado se realizan las siguientes
  # transformaciones (similares a las que realiza el helper de rails 
  # radio_button_tag):
  #   - Pasa a minúsculas todas las letras,
  #   - Sustituye los espacios por guiones bajos ("_").
  #
  ########################################################################
    Cuando visito la portada
         Y elijo la nacionalidad Pakistaní
         Y pincho el botón "Galleta de la fortuna"
    Entonces veo el tag div#nacionalidad con el valor "Pakistaní"
    
    Cuando visito la portada
         Y elijo "Color verde"
         Y pincho el botón "Galleta de la fortuna"
    Entonces veo el tag div#color con el valor "verde"
