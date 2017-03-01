Feature: Contact us
  In order to inquiry anything about the website
  As a guest or signed in user
  I want to contact the staff

  Scenario: Contact from a visitor
    Given I am on the root page
    When I click on "Entre em contato"
    And I fill in "Nome" with "Stannis Baratheon"
    And I fill in "Email" with "stannis@baratheon.com"
    And I fill in "Mensagem" with "Joffrey is not Robert's son!"
    And I click on "Enviar"
    Then I am redirected to the root page
    And I see the info message "Muito obrigado pela sua mensagem. Vamos te responder por email em breve."
    And an email is sent to "contato@mundodastrevas.com"
    And the email contains "Joffrey is not Robert's son!"
    And the email contains "Stannis Baratheon"
    And the email contains "stannis@baratheon.com"

  Scenario: Contact from a visitor without a name
    Given I am on the root page
    When I click on "Entre em contato"
    And I don't fill in "Nome"
    And I click on "Enviar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Nome" with the error "não pode ficar em branco"

  Scenario: Contact from a visitor without an email
    Given I am on the root page
    When I click on "Entre em contato"
    And I don't fill in "Email"
    And I click on "Enviar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Email" with the error "não pode ficar em branco"

  Scenario: Contact from a visitor with an invalid email
    Given I am on the root page
    When I click on "Entre em contato"
    And I fill in "Email" with "ican'twriteanemail"
    And I click on "Enviar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Email" with the error "não é válido"

  Scenario: Contact from a visitor without a message
    Given I am on the root page
    When I click on "Entre em contato"
    And I don't fill in "Mensagem"
    And I click on "Enviar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "Mensagem" with the error "não pode ficar em branco"
