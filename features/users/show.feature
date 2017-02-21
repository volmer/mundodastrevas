Feature: Show user
  In order to check an user info
  As a signed in user
  I want to view the user profile page

  Background:
    Given I am signed up with the following data:
      | name     | email               | gender | bio                  | location   | birthday   |
      | catelyn  | catelyn@example.com | female | Duty, family, honor. | Winterfell | 1959-05-22 |
    And I am signed in

  Scenario: Show user to a signed in user
    When I go to my profile page
    Then I see "catelyn" on the page
    And I see "Duty, family, honor" on the page
    And I see the field "Sexo" with the value "Feminino"
    And I see the field "Email" with the value "catelyn@example.com"
    And I see the field "Localização" with the value "Winterfell"
    And I see the field "Data de nascimento" with the value "22/05/1959"

  Scenario: Show user with an unconfirmed email
    Given I have an unconfirmed email "newemail@example.com"
    When I go to my profile page
    Then I see the field "Email" with the value "catelyn@example.com"
    And I see "Aguardando confirmação para newemail@example.com" on the page
