Característica: debería ver un campo con un valor concreto

  Escenario: Debería ver un campo de texto con un valor concreto 
  ########################################################################
  # Patrón: 
  #   Debería ver el campo _campo_ con (el valor)? _valor_
  #   Veo el campo _campo_ con (el valor)? _valor_
  #
  ########################################################################
    Cuando visito la portada
         Y relleno "Campo de texto" con "Fertilizador"
    Entonces debería ver el campo "Campo de texto" con el valor "Fertilizador"
