Feature: Facebook authentication
  In order to easily sign in/sign up
  As a Facebook user
  I want to authenticate using my Facebook account

  Background:
    Given I have a Facebook account with the following information:
      | email            | name          | bio        | gender | birthday   | location | image     |
      | theon@greyjoy.ws | Theon Greyjoy | Not human. | female | 10/20/1990 | Pyke     | theon.jpg |
    And I am not signed in

  Scenario: Sign up successfully
    Given I am on the new user session page
    When I click on "Entrar com Facebook"
    Then I am redirected to the root page
    And I see the info message "Você entrou com sua conta do Facebook. Bem-vindo!"
    And I go to my profile page
    And I see "theon" on the page
    And I see the link "Facebook" which leads to the "http://facebook.com/my_profile" URL
    And I see the field "Email" with the value "theon@greyjoy.ws"
    And I see "Not human." on the page
    And I see the field "Sexo" with the value "Feminino"
    And I see the field "Data de nascimento" with the value "20/10/1990"
    And I see the field "Localização" with the value "Pyke"
    And I see the image "theon.jpg" as my avatar

  Scenario: Sign in using Facebook
    Given I am signed up with the following data:
      | name          | email            |
      | theongreyjoy  | theon@greyjoy.ws |
    And I am on the new user session page
    When I click on "Entrar com Facebook"
    Then I am redirected to the root page
    And I see the info message "Você entrou com sua conta do Facebook. Bem-vindo!"
    And I go to my profile page
    And I see "theongreyjoy" on the page
    And I see the link "Facebook" which leads to the "http://facebook.com/my_profile" URL
    And I see the field "Email" with the value "theon@greyjoy.ws"
    And I see "Not human." on the page
    And I see the field "Sexo" with the value "Feminino"
    And I see the field "Data de nascimento" with the value "20/10/1990"
    And I see the field "Localização" with the value "Pyke"
    And I see the image "theon.jpg" as my avatar

  Scenario: Complete sign up with some invalid Facebook data
    Given I have a Facebook account with the following information:
      | name     | bio          | gender | birthday   | location | image   |
      | Jon Snow | I'm no crow. | male   | 08/16/1991 | The Wall | jon.jpg |
    And I am on the new user session page
    When I click on "Entrar com Facebook"
    And I see the field "Nome" filled in with "jon-snow"
    And I fill in "Email" with "jon@thewall.ws"
    And I fill in "Senha" with "12345678"
    And I fill in "Confirmação da senha" with "12345678"
    And I click on "Cadastrar"
    And I confirm my registration
    And I sign in with name "jon-snow" and password "12345678"
    And I go to my profile page
    Then I see "jon-snow" on the page
    And I see the field "Email" with the value "jon@thewall.ws"
    And I see "I'm no crow." on the page
    And I see the field "Sexo" with the value "Masculino"
    And I see the field "Data de nascimento" with the value "16/08/1991"
    And I see the field "Localização" with the value "The Wall"
    And I see the image "jon.jpg" as my avatar
    And I see the link "Facebook" which leads to the "http://facebook.com/my_profile" URL
