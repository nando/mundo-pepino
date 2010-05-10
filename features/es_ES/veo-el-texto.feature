# language: es
Característica: veo (o no) un texto opcionalmente dentro de un selector

  Escenario: Veo (o no) un texto
  ########################################################################
  # Patrón:
  #   Entonces (no) debería ver el texto _texto_
  #   Entonces (no) debo ver el texto _texto_ dentro de _selector_
  #   Entonces (no) veo el texto _texto_ dentro de la etiqueta _selector_
  #   Entonces (no) veo el texto _texto_ dentro del selector _selector_
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
           Y debería ver el texto "Mundo Pepino"
           Y debería ver el texto /mundo\s[a-z]+/i
           Y debo ver el texto app.welcome.title
           Y debo ver el texto app.welcome.interpolated,{ :name => 'Nombre' }
           Y debo ver el texto app.welcome.interpolated,{ :name => "Nombre" }
           Y no debo ver el texto Cucumber
           Y no veo el texto "Rocks"

  Escenario: Veo (o no) un texto dentro de un selector
    Cuando visito la portada
    Entonces veo el texto Portada dentro de "h1"
           Y veo el texto Portada dentro del selector h1
           Y veo el texto "Mundo" dentro de la etiqueta h1
           Y veo el texto /mundo\s[a-z]+/i dentro de h1
           Y no veo el texto /mundo\s[a-z]+/i dentro de form           
    

