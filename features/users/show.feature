Feature: Show user
  In order to check an user info
  As a signed in user
  I want to view the user profile page

  Background:
    Given there is an user signed up with the following data:
      | name     | email               | gender | bio                  | location   | birthday   |
      | catelyn  | catelyn@example.com | female | Duty, family, honor. | Winterfell | 1959-05-22 |

  Scenario: Show user to a signed in user
    Given I am signed in
    When I go to catelyn's profile page
    Then I see the page heading "catelyn"
    And I see "Duty, family, honor" on the page
    And I see the field "Sexo" with the value "Feminino"
    And I see the field "Email" with the value "catelyn@example.com"
    And I see the field "Localização" with the value "Winterfell"
    And I see the field "Data de nascimento" with the value "22/05/1959"
    And I see an activity called "catelyn entrou no Mundo das Trevas"

  Scenario: Show user to a non signed in user
    Given I am not signed in
    When I go to catelyn's profile page
    Then I am redirected to the new user session page

  Scenario: Show user with an unconfirmed email
    Given I am signed in
    And catelyn has an unconfirmed email "newemail@example.com"
    When I go to catelyn's profile page
    Then I see the field "Email" with the value "catelyn@example.com"
    And I don't see "newemail@example.com" on the page

