# language: es
Característica: debería ver un campo con un valor concreto

  Escenario: Debería ver un campo de texto con un valor concreto
  ########################################################################
  # Patrón: 
  #   Debería ver el campo _campo_ con (el valor|el texto)? _valor_
  #   Veo el campo _campo_ con (el valor|el texto)? _valor_
  #
  # Para comprobar que el campo está vacío tenemos
  #   Veo el campo _campo_ vacío 
  #
  ########################################################################
    Cuando visito la portada
         Y relleno "Campo de texto" con "Fertilizador"
    Entonces debería ver el campo "Campo de texto" con el valor "Fertilizador"
         Y debería ver el campo "Campo de texto" con el texto "Fertilizador"
         Y debería ver el campo "Campo de texto" con "Fertilizador"
         Y debo ver el campo "Campo de texto" con el valor "Fertilizador"
         Y debo ver el campo "Campo de texto" con el texto "Fertilizador"
         Y debo ver el campo "Campo de texto" con "Fertilizador"
         Y veo el campo "Campo de texto" con el valor "Fertilizador"
         Y veo el campo "Campo de texto" con el texto "Fertilizador"
         Y veo el campo "Campo de texto" con "Fertilizador"

  Escenario: Debería poder comprobar que el campo está vacío con una expresión regular
     Cuando visito la portada
     Entonces debería ver el campo "Nombre de usuario" con el valor "^$"

  Escenario: Debería poder comprobar que el campo está vacío
     Cuando visito la portada
     Entonces debería ver el campo "Nombre de usuario" vacío
