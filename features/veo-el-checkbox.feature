Característica: veo el checkbox en un estado

  Escenario: Veo marcada (o desmarcada) una casilla (*checkbox*)  
  ########################################################################
  # Patrón: 
  #   Entonces (no) debo ver marcada (la casilla/el checkbox) _label_
  # 
  # Descripción:
  #   Comprueba que se encuentra seleccionado el campo checkbox etiquetado
  # como _label_.
  #
  ########################################################################
    Cuando visito la portada
    Entonces debo ver marcada la casilla Seleccionado
           Y debo ver marcado el checkbox Seleccionado
           Y debo ver marcado Seleccionado
           Y veo marcado Seleccionado
           Y no debo ver marcada la casilla "Sin seleccionar"
           Y no debo ver marcado el checkbox "Sin seleccionar"
           Y no debo ver marcada "Sin seleccionar"
           Y no veo marcada "Sin seleccionar"
