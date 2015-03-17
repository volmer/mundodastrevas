Feature: Destroy registration
  In order to remove all my data once and for all
  As a user
  I want to destroy my registration

  Background:
    Given I am signed up with the following data:
      | name   | email              | password |
      | volmer | volmer@example.com | 12345678 |
    And I am signed in
    And I am on the edit user registration page

  Scenario: Successfully destroy registration
    When I click on "Destruir conta"
    And I fill in "Senha" with "12345678"
    And I click on "Eu entendo as consequências. Destrua minha conta."
    Then I am redirected to the root page
    And I am no longer signed in
    And I see the info message "Até mais! Sua conta foi cancelada com sucesso. Esperamos vê-lo novamente em breve."

  Scenario: Destroy with a blank password
    When I click on "Destruir conta"
    And I fill in "Senha" with ""
    And I click on "Eu entendo as consequências. Destrua minha conta."
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Senha" with the error "não pode ficar em branco"

  Scenario: Destroy with an invalid password
    When I click on "Destruir conta"
    And I fill in "Senha" with "87654321"
    And I click on "Eu entendo as consequências. Destrua minha conta."
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Senha" with the error "não é válido"
