Característica: veo (o no) un texto

  Escenario: Veo (o no) un texto 
  ########################################################################
  # Patrón:
  #   Entonces (no) debo ver el texto _texto_
  # o:
  #   Entonces (no) veo el texto _texto_
  #
  # Ejemplos:
  #   Entonces debo ver el texto "IVA incluido"
  #   Entonces veo el texto "IVA no incluido"
  #
  # Descripción:
  #   Comprueba que _texto_ está presente en el cuerpo del documento.
  #
  ########################################################################
    Cuando visito la portada
    Entonces veo el texto Portada
           Y debo ver el texto "Mundo Pepino"
           Y debo ver el texto app.welcome.title
           Y debo ver el texto app.welcome.interpolated,{ :name => 'Nombre' }
           Y no debo ver el texto Cucumber
           Y no veo el texto "Rocks"
