Feature: MP gives good feedback :through exceptions
  Background:
      Given a crop called 'My crop'
        And three lettuces called 'A, B and C' 
        And the following default params:
        |key             |value      |
        |:model          |crop       |
        |:name           |My crop    |
        |:children_field |lettuces   |
        |:children_names |A, B and C |
        |:field          |name       |
        |:value          |My new crop|

  Scenario Outline:
    Given the step implementation <step_implementation>
    When I call it with default params merged with <raiser_param>
    Then I should receive the <exception> exception
  Examples:
|step_implementation                                  |raiser_param          |exception                   |
|given_we_have_a_number_of_instances_called           |:model=>'unmapped'    |ModelNotMapped              |
|given_we_have_the_following_instances_from_step_table|:model=>'unmapped'    |ModelNotMapped              |
|given_resource_has_value_in_field                    |:model=>'unmapped'    |ModelNotMapped              |
|given_resource_has_value_in_field                    |:name=>'U'            |NotFoundInHistoryNorDatabase|
|given_resource_has_value_in_field                    |:field=>'foo'         |FieldNotMapped              |
|given_resource_has_many_children                     |:model=>'unmapped'    |ModelNotMapped              |
|given_resource_has_many_children                     |:name=>'U'            |NotFoundInHistoryNorDatabase|
|given_resource_has_many_children                     |:children_field=>'foo'|ModelNotMapped              |
|given_resource_has_many_children_from_step_table     |:model=>'unmapped'    |ModelNotMapped              |
|given_resource_has_many_children_from_step_table     |:name=>'U'            |NotFoundInHistoryNorDatabase|
|given_resource_has_many_children_from_step_table     |:children_field=>'foo'|ModelNotMapped              |
|then_we_have_a_number_of_instances_in_our_database   |:model=>'unmapped'    |ModelNotMapped              |
|then_resource_called_name_should_have_n_children     |:model=>'unmapped'    |ModelNotMapped              |
|then_resource_called_name_should_have_n_children     |:name=>'U'            |NotFoundInDatabase          |
|then_resource_called_name_should_have_n_children     |:children_field=>'foo'|ModelNotMapped              |
