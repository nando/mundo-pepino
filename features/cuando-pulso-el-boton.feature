Característica: pulso el botón

  Escenario: Pincho en un bóton (*submit*)
  ########################################################################
  # Patrón: 
  #   Cuando (pulso|pincho) (en)? el botón _input_value_
  #
  # Ejemplos:
  #   Cuando pulso en el botón 'Enviar la foto'
  #   Cuando pulso el botón Enviar
  #
  # Descripción:
  #   Solicita la navegación a 
  #
  ########################################################################
    Cuando visito la portada
         Y pincho el botón Galleta de la Fortuna
    Entonces veo la etiqueta H1 con el valor "Sorry, not implemented yet"
    Cuando visito la portada
         Y pulso en el botón app.welcome.cookie_fortune
    Entonces veo la etiqueta H1 con el valor "Sorry, not implemented yet"
     
  Escenario: Pincho en un bóton (desde Given)
    Dado que visito la portada
       Y que pulso en el botón Galleta de la Fortuna
    Entonces veo la etiqueta H1 con el valor "Sorry, not implemented yet"
      
