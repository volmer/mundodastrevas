@javascript
Feature: Search posts
  In order to find what I'm looking for
  As a guest or a registered user
  I want to perform a search

  Background:
    Given I am on the root page

  Scenario: Query a term through post names
    Given there is a post called "Brienne"
    When I fill in "query" with "brienne"
    And I press enter in "query"
    Then I see the link "Brienne"

  Scenario: Find a term in a post content
    Given there is a post with the given attributes:
      | name | content     |
      | Arya | Why, ned?   |
    When I fill in "query" with "ned"
    And I press enter in "query"
    And I see the link "Arya"
