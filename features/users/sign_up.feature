Feature: User sign up
  In order to become a member of this awesome community
  As a visitor
  I want to sign up

  Background:
    Given I am not signed in
    And I go to the new user registration page

  Scenario: Successful sign up
    When I fill in "Nome" with "volmer"
    And I fill in "Email" with "volmer@example.com"
    And I fill in "Senha" with "12345678"
    And I fill in "Confirmação da senha" with "12345678"
    And I click on "Cadastrar"
    Then I am redirected to the root page
    And I see the info message "Uma mensagem com um link de confirmação foi enviado para o seu email. Por favor, abra o link para ativar sua conta."
    And I receive an email titled "Instruções para confirmar sua conta"

  Scenario Outline: Sign up without a required field
    When I fill in "Nome" with "<name>"
    And I fill in "Email" with "<email>"
    And I fill in "Senha" with "<password>"
    And I fill in "Confirmação da senha" with "<password>"
    And I click on "Cadastrar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "<invalid field>" with the error "não pode ficar em branco"

    Examples:
      | name   | email              | password | invalid field |
      |        | volmer@example.com | 12345678 | Nome          |
      | volmer |                    | 12345678 | Email         |
      | volmer | volmer@example.com |          | Senha         |

  Scenario Outline: Sign up with a valid name
    When I fill in "Nome" with "<name>"
    And I click on "Cadastrar"
    Then I see no errors in the field "Nome"

    Examples:
      | name             |
      | vol              |
      | volmer           |
      | 123volmer        |
      | vol_mer          |
      | volmervolmervolm |
      | v--ol-mer        |

  Scenario Outline: Sign up with Name in an invalid format
    When I fill in "Nome" with "<name>"
    And I click on "Cadastrar"
    And I see the danger message "Verifique os erros abaixo:"
    And I see the field "Nome" with the error "não é válido"

    Examples:
      | name       |
      | vol mer    |
      | v.o.l.m.er |
      | volm@r     |

  Scenario: Sign up with a too short Name
    When I fill in "Nome" with "vo"
    And I click on "Cadastrar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Nome" with the error "é muito curto (mínimo: 3 caracteres)"

  Scenario: Sign up with a too long Name
    When I fill in "Nome" with "vovovovovovovovov"
    And I click on "Cadastrar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Nome" with the error "é muito longo (máximo: 16 caracteres)"

  Scenario: Sign up with a Name already in use
    Given there is an user signed up with the following data:
      | name   |
      | volmer |
    When I fill in "Nome" with "volmer"
    And I click on "Cadastrar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Nome" with the error "já está em uso"

  Scenario: Sign up with e-mail in an invalid format
    When I fill in "Email" with "aninvalidemail"
    And I click on "Cadastrar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Email" with the error "não é válido"

  Scenario: Sign up with an e-mail already in use
    Given there is an user signed up with the following data:
      | email              |
      | volmer@example.com |
    When I fill in "Email" with "volmer@example.com"
    And I click on "Cadastrar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Email" with the error "já está em uso"

  Scenario: Sign up with a wrong password confirmation
    When I fill in "Senha" with "12345678"
    And I fill in "Confirmação da senha" with "111111"
    And I click on "Cadastrar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Confirmação da senha" with the error "não está de acordo com a confirmação"
