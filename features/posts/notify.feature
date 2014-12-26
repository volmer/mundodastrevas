Feature: Notify watchers
  In order to be aware of new comments
  As a user watching a post
  I want to receive notifications about new comments

  Background:
    Given I am signed in as "volmer"
    And there is a zine called "A Storm of Swords"
    And within "A Storm of Swords" there is a post called "Arya"
    And I am watching the post "Arya"

  Scenario: Notify watchers
    Given there is an user called "davos"
    And davos wrote a new comment on the post "Arya"
    When I go to the notifications page
    Then I see "davos comentou em Arya." on the page
    And I receive an email titled "Novo comentário em Arya"
    And the email contains "volmer"
    And the email contains "davos"
    And the email contains "Arya"
    And the email contains "preferências de email"

  Scenario: Disable email
    Given I've unchecked "Comentários em posts que eu estou vigiando" in my email preferences
    And there is an user called "davos"
    And davos wrote a new comment on the post "Arya"
    When I go to the notifications page
    Then I see "davos comentou em Arya." on the page
    And I don't receive any emails
