Feature: Change password
  In order to improve my security
  As an user
  I want to change my password

  Background:
    Given I am signed up with the following data:
      | name   | email              | password |
      | volmer | volmer@example.com | 12345678 |
    And I sign in with name "volmer" and password "12345678"
    And I open my user menu
    And I click on "Configurações"
    And I click on "Alterar senha"

  Scenario: Successful password change
    When I fill in "Nova senha" with "mypassword66"
    And I fill in "Senha atual" with "12345678"
    And I press "Alterar"
    Then I see the info message "Senha alterada!"
    And my password is now "mypassword66"

  Scenario: Wrong Senha atual
    When I fill in "Senha atual" with "111111"
    And I press "Alterar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Senha atual" with the error "não é válido"

  Scenario: Nova senha is less than 8 characters long
    When I fill in "Nova senha" with "1234567"
    And I fill in "Senha atual" with "12345678"
    And I press "Alterar"
    And I see the field "Nova senha" with the error "é muito curto"
