Feature: Notify watchers
  In order to be aware of new posts
  As a user watching a topic
  I want to receive notifications about new posts

  Background:
    Given I am signed in as "volmer"
    And there is a topic called "Treason!" in "Small Council"
    And I am watching the topic "Treason!"

  Scenario: Notify watchers
    Given there is an user called "davos"
    And davos wrote a new post on the topic "Treason!"
    When I go to the notifications page
    Then I see "davos postou em Treason!." on the page
    And I receive an email titled "Nova postagem em Treason!"
    And the email I've received contains "volmer"
    And the email I've received contains "davos"
    And the email I've received contains "Treason!"
    And the email I've received contains "preferências de email"

  Scenario: Disable email
    Given I've unchecked "Novas postagens em tópicos que eu estou vigiando" in my email preferences
    And there is an user called "davos"
    And davos wrote a new post on the topic "Treason!"
    When I go to the notifications page
    Then I see "davos postou em Treason!." on the page
    And I don't receive any emails
