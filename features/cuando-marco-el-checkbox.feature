Característica: marco el checkbox

  Escenario: Marco (o desmarco) una casilla (*checkbox*)  
  ########################################################################
  # Patrón:
  #   Cuando marco (la/el)? _checkbox_id_
  #
  # Ejemplos:
  #   Cuando desmarco color_verde
  #   Cuando marco el "color verde"
  #
  # Descripción:
  #   Selecciona el checkbox con el identificador indicado admitiendo
  # comillas opcionalmente. 
  # 
  #   Sobre el identificador facilitado se sustituyen los espacios por 
  # guiones bajos ("_").
  #
  ########################################################################
    # Pre-checking
    Cuando visito la portada
         Y pincho en el botón "Galleta de la fortuna"
    Entonces veo el tag div#selected_check con el valor "Seleccionado"
           Y no veo el tag div#unselected_check con el valor "Sin seleccionar"

    # Let's go for it...
    Cuando visito la portada
         Y desmarco la casilla seleccionada
         Y marco la casilla sin seleccionar
         Y pincho en el botón "Galleta de la fortuna"
    Entonces no veo el tag div#selected_check con el valor "Seleccionado"
           Y veo el tag div#unselected_check con el valor "Sin seleccionar"

    Escenario: Marco una casilla o checkbox (desde Given)
    Dado que visito la portada
       Y que desmarco la casilla seleccionada
       Y que marco la casilla sin seleccionar
    Cuando pincho en el botón "Galleta de la fortuna"
    Entonces no veo el tag div#selected_check con el valor "Seleccionado"
           Y veo el tag div#unselected_check con el valor "Sin seleccionar"
