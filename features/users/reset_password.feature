Feature: Reset password
  In order to recover access to my account
  As a user who forgot her/his password
  I want to reset my password

  Background:
    Given I am signed up with the following data:
      | email              |
      | volmer@example.com |
    And I am not signed in
    And I go to the new user session page
    And I click on "Esqueceu sua senha?"

  Scenario: Sucessful password reset
    When I fill in "Email" with "volmer@example.com"
    And I press "Enviar instruções de troca de senha"
    Then I see the info message "Você receberá um email com instruções para redefinir sua senha em poucos minutos."
    And I receive an email titled "Instruções para redefinir sua senha"

  Scenario: Reset password with an invalid email
    When I fill in "Email" with "scumbag@example.com"
    And I press "Enviar instruções de troca de senha"
    And I see the field "Email" with the error "não encontrado"

  Scenario: Reset password without providing an email
    When I don't fill in "Email"
    And I press "Enviar instruções de troca de senha"
    And I see the field "Email" with the error "não pode ficar em branco"

