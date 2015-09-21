@javascript
Feature: Search zine
  In order to find what I'm looking for
  As a guest or a registered user
  I want to perform a search

  Background:
    Given I am on the root page

  Scenario: Query a term through zine names
    Given there is a zine called "A Feast of Crows"
    When I fill in "q" with "crow"
    And I press enter in "q"
    Then I see the link "A Feast of Crows"

  Scenario: Find a term in a zine description
    Given there is a zine with the given attributes:
      | name              | description |
      | A Game of Thrones | Why, ned?   |
    When I fill in "q" with "ned"
    And I press enter in "q"
    And I see the link "A Game of Thrones"
