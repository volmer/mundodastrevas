Feature: Exchange messages
  In order to communicate with other users
  As a user
  I want to exchange messages with them

  Background:
    Given I am signed in
    And there is an user called "bran"

  Scenario: Send a message
    When I go to bran's profile page
    And I click on "Mensagem"
    And I fill in "message_content" with "Hello, bran! Winter is coming!"
    And I click on "Enviar"
    Then I see "Hello, bran! Winter is coming!" on the page
