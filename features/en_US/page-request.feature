Feature: Then I see a text

  Scenario Outline: Then I see a text
  ########################################################################
  # TODO: Doc. this
  #
  ########################################################################
    Given <i_do_a_page_request>
    Then I should see the text Mundo Pepino
    When <i_do_a_page_request>
    Then I should see the text Mundo Pepino
  Examples:
    | i_do_a_page_request              | 
    | I visit the homepage        |
#    | I go to the homepage        |
#    | that I am in the homepage  |
#    | that I am on the homepage  |
#    | that I am at the homepage  |
