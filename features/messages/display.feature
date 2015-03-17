Feature: Display messages
  In order to manage my messages
  As a user
  I want to read my messages in a well organized way

  Background:
    Given I am signed in
    And there is an user called "aemon"
    And aemon has sent me the message: "I am the last Targaryen"

  @javascript
  Scenario: View counter of unread messages
    When I open my user menu
    Then I see "Mensagens 1" on the page

  @javascript
  Scenario: View message in the messages inbox
    When I open my user menu
    And I click on "Mensagens 1"
    Then I see "aemon" on the page
    And I see "I am the last Targaryen" on the page

  @javascript
  Scenario: Read message
    When I open my user menu
    And I click on "Mensagens 1"
    And I click on "aemon"
    And I open my user menu
    Then I don't see "Mensagens 1" on the page

  Scenario: Paginate messages inbox
    Given I have exchanged messages with 22 users
    When I go to the messages page
    Then I see 3 pages
    And I see 10 messages
    # user will see 3 users in the last page, because aemon is computed too
    And I see 3 messages in the page 3

