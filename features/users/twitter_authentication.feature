Feature: Twitter authentication
  In order to easily sign in/sign up
  As a Twitter user
  I want to authenticate using my Twitter account

  Background:
    Given I have a Twitter account with the following information:
      | username | bio        | location | image     |
      | theon    | Not human. | Pyke     | theon.jpg |
    And I am not signed in

  Scenario: Complete sign up with Twitter data
    Given I am on the new user session page
    When I click on "Entrar com Twitter"
    And I see the field "Nome" filled in with "theon"
    And I fill in "Email" with "theon@greyjoy.ws"
    And I fill in "Senha" with "12345678"
    And I fill in "Confirmação da senha" with "12345678"
    And I click on "Cadastrar"
    And I confirm my registration
    And I sign in with the name "theon" and the password "12345678"
    And I go to my profile page
    Then I see the page heading "theon"
    And I see the field "Email" with the value "theon@greyjoy.ws"
    And I see the field "Localização" with the value "Pyke"
    And I see the image "theon.jpg" as my avatar
    And I see the link "Twitter" which leads to "http://twitter.com/theon" when clicked
