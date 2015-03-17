Feature: Notify watchers
  In order to be aware of relevant events
  As a user watching an item
  I want to receive notifications about it

  Background:
    Given there is a post called "Awesome post"
    And I am signed in as "volmer"
    And I am watching the post

  Scenario: Notify watchers
    Given there is an user called "davos"
    And davos has commented on the "Awesome post" post
    When I go to the notifications page
    Then I see "davos comentou em Awesome post." on the page
    And I receive an email titled "Novo comentário em Awesome post"
    And the email contains "davos"
    And the email contains "Awesome post"

  Scenario: Skip notification for the event author
    Given I'm on the "Awesome post" post page
    When I fill in "comment_content" with "My comment"
    And I click on "Comentar"
    And I go to the notifications page
    Then I don't see any notifications

  Scenario: Disable email
    Given I've unchecked "Comentários em posts que eu estou vigiando" in my email preferences
    And there is an user called "davos"
    And davos has commented on the "Awesome post" post
    When I go to the notifications page
    Then I see "davos comentou em Awesome post." on the page
    And I don't receive any emails
