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

  Scenario: Receive a message
    Given bran has sent me the message: "Yes, brace yourself!"
    When I go to the notifications page
    Then I see 1 unread notification
    And I click on "Mensagem de bran"
    Then I see "Yes, brace yourself!" on the page
