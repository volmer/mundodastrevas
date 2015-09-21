@javascript
Feature: Search
  In order to find what I'm looking for
  As a guest or a registered user
  I want to perform a search

  Background:
    Given I am on the root page

  Scenario: Query a term through forums, topics and forum posts
    Given there is a topic called "I want to kill a Lannister" in the "Lannister haters" forum
    And there is a forum post "I just don't know with whom I should start." in the "I want to kill a Lannister" topic
    And there is a forum post "Cersei Lannister?" in the "I want to kill a Lannister" topic
    When I fill in "q" with "lannister"
    And I press enter in "q"
    Then I see the link "Lannister haters"
    And I see the link "I want to kill a Lannister"
    And I see "I just don't know with whom I should start." on the page
    And I see "Cersei Lannister?" on the page

  Scenario: Find a term in a forum description
    Given there is a forum with the given attributes:
      | name          | description                         |
      | The Gathering | Reunion of the High Wizards of Myr. |
    When I fill in "q" with "myr"
    And I press enter in "q"
    And I see the link "The Gathering"
