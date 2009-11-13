Feature: Then I see a text

  Scenario: Then I see a text
  ########################################################################
  # TODO: Translate this
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
    When I visit the homepage
    Then I should see the text Mundo Pepino
           And I should see the text "Mundo Pepino"
           And I should see the text app.welcome.title
           And I should see the text app.welcome.interpolated,{ :name => 'Nombre' }
           And I should not see the text Cucumber
           And I should not see the text "Rocks"
