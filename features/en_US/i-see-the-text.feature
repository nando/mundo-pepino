Feature: Then I see a text

  Scenario: Then I see a text
  ########################################################################
  # Syntax:
  #	  Then I (should not|should) see the text _text_	
  #
  # Examples:
  #   Then I should see the text "Tax included" 
  #	  Then I should not see the text "Tax included" 
  #
  # Description:
  #   Checks that the _text_ is present in the response body
  #
  ########################################################################
    When I visit the homepage
    Then I should see the text Mundo Pepino
     And I should see the text "Mundo Pepino"
     And I should see the text app.welcome.title
     And I should see the text app.welcome.interpolated,{ :name => 'Nombre' }
     And I should not see the text Cucumber
     And I should not see the text "Rocks"
