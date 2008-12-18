Característica: veo el checkbox en un estado

  Escenario: Veo marcada (o desmarcada) una casilla (*checkbox*)  
  ########################################################################
  # Patrón: 
  #   Entonces (no) debo ver marcada (la casilla) _label_
  #
  # Descripción:
  #   
  #
  ########################################################################
    Cuando visito la portada
    Entonces debo ver marcada la casilla Seleccionado
           Y debo ver marcado Seleccionado
           Y veo marcado Seleccionado
           Y no debo ver marcada la casilla "Sin seleccionar"
           Y no debo ver marcada "Sin seleccionar"
           Y no veo marcada "Sin seleccionar"
