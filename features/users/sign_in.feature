Feature: User sign in
  In order to get access to protected sections
  As an user
  I want to be able to sign in

  Background:
    Given I am signed up with the following data:
      | name   | email              | password |
      | volmer | volmer@example.com | 12345678 |
    And I am not signed in
    And I go to the new user session page

  Scenario Outline: Successfull sign in
    When I fill in "Nome ou email" with "<login>"
    And I fill in "Senha" with "12345678"
    And I press "Entrar"
    Then I am redirected to the root page
    And I am successfully signed in as "volmer"

    Examples:
      | login              |
      | volmer@example.com |
      | volmer             |
