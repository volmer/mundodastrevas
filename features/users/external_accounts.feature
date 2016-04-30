Feature: Manage external accounts
  In order to keep my information up-to-date
  As a user
  I wanto to view, create and delete my external accounts

  Background:
    Given I am signed in as "georgerrmartin"

  Scenario: List external accounts
    Given I am on the edit user registration page
    When I click on "Contas externas"
    Then I see "Facebook" on the page

  Scenario: Connect Facebook account
    Given I have a Facebook account with the following information:
      | email            | bio        | gender | birthday   | location | image     |
      | theon@greyjoy.ws | Not human. | female | 10/20/1990 | Pyke     | theon.jpg |
    When I go to the user external accounts page
    And I click on "Conectar conta do Facebook"
    Then I am redirected to the user external accounts page
    And I see the info message "Você entrou com sua conta do Facebook. Bem-vindo!"
    And I see "theon@greyjoy.ws" on the page
    And I go to my profile page
    And I see the link "Facebook" which leads to the "http://facebook.com/my_profile" URL
    And I see "Not human." on the page
    And I see the field "Sexo" with the value "Feminino"
    And I see the field "Data de nascimento" with the value "20/10/1990"
    And I see the field "Localização" with the value "Pyke"
    And I see the image "theon.jpg" as my avatar

  Scenario: Disconnect Facebook account
    Given I've connected my Facebook account
    When I go to the user external accounts page
    And I click on "Desconectar Facebook"
    Then I am redirected to the user external accounts page
    And I see the info message "Você não está mais conectado via Facebook."
    And I go to my profile page
    And within my profile I do not see the link "Facebook"
