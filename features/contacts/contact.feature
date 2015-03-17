Feature: Contact us
  In order to inquiry anything about the website
  As a guest or signed in user
  I want to contact the staff

  Background:
    Given the email destination for contacts is "staff@example.com"

  Scenario: Contact from a guest
    Given I am not signed in
    And I am on the root page
    When I click on "Entre em contato"
    And I fill in "Nome" with "Stannis Baratheon"
    And I fill in "Email" with "stannis@baratheon.com"
    And I fill in "Mensagem" with "Joffrey is not Robert's son!"
    And I click on "Enviar"
    Then I am redirected to the root page
    And I see the info message "Muito obrigado pela sua mensagem. Vamos te responder por email em breve."
    And an email is sent to "staff@example.com"
    And the email contains "Joffrey is not Robert's son!"
    And the email contains "Stannis Baratheon"
    And the email contains "stannis@baratheon.com"

  Scenario: Contact from a signed in user
    Given I am signed up with the following data:
      | name     | email                   |
      | stannis  | stannis@dragonstone.com |
    And I am signed in
    And I am on the root page
    When I click on "Entre em contato"
    And I fill in "Mensagem" with "Joffrey is an abomination!"
    And I click on "Enviar"
    Then I am redirected to the root page
    And I see the info message "Muito obrigado pela sua mensagem. Vamos te responder por email em breve."
    And an email is sent to "staff@example.com"
    And the email contains "Joffrey is an abomination!"
    And the email contains "stannis"
    And the email contains "stannis@dragonstone.com"

  Scenario: Contact from a guest without a name
    Given I am not signed in
    And I am on the root page
    When I click on "Entre em contato"
    And I don't fill in "Nome"
    And I click on "Enviar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Nome" with the error "não pode ficar em branco"

  Scenario: Contact from a guest without an email
    Given I am not signed in
    And I am on the root page
    When I click on "Entre em contato"
    And I don't fill in "Email"
    And I click on "Enviar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Email" with the error "não pode ficar em branco"

  Scenario: Contact from a guest with an invalid email
    Given I am not signed in
    And I am on the root page
    When I click on "Entre em contato"
    And I fill in "Email" with "ican'twriteanemail"
    And I click on "Enviar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Email" with the error "não é válido"

  Scenario: Contact from a guest without a message
    Given I am not signed in
    And I am on the root page
    When I click on "Entre em contato"
    And I don't fill in "Mensagem"
    And I click on "Enviar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Mensagem" with the error "não pode ficar em branco"

  Scenario: Contact from a signed in user without a message
    Given I am signed in
    And I am on the root page
    When I click on "Entre em contato"
    And I don't fill in "Mensagem"
    And I click on "Enviar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Mensagem" with the error "não pode ficar em branco"
