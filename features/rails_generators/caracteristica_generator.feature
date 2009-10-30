Feature: caracteristica generator

  Background:
    Given a Rails app
    And "mundo-pepino" in "." as one of its plugins
    And "string-mapper" in "features/support/app/vendor/plugins/string-mapper" as one of its plugins
    And I run executable "script/generate" with arguments "cucumber"
    
  Scenario: generate caracteristica
    Given I run executable "script/generate" with arguments "mundo_pepino"
    
    And I run executable "script/generate" with arguments "caracteristica Orchard Huerto name:string:nombre"
    And I run executable "script/generate" with arguments "scaffold Orchard name:string"
    And I invoke task "rake db:migrate"
    And I invoke task "rake caracteristicas"

    Then I should see '2 scenarios'
    And I should see '7 steps'
    And I should see 'Could not find link with text or title or id "Borrar"'
    And I should see 'Could not find button "Crear"'
