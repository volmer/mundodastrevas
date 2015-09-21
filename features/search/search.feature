@javascript
Feature: Search
  In order to find what I'm looking for
  As a guest or a registered user
  I want to perform a search

  Background:
    Given I am on the root page

  Scenario: Query a term through users and pages
    Given there is a page with the following data:
      | title         |
      | Stark's Words |
    And there is an user called "sansa_stark"
    When I fill in "q" with "stark"
    And I press enter in "q"
    Then I see the link "sansa_stark"
    And I see the link "Stark's Words"

  Scenario: Search for inexistent data
    Given there is an user called "jon"
    And there is an user called "robb"
    When I fill in "q" with "arya"
    And I press enter in "q"
    Then I see "Nenhum resultado encontrado." on the page

  Scenario: Find a term in a page content
    Given there is a page with the following data:
      | title           | content           |
      | Valar Morghulis | All men must die. |
    When I fill in "q" with "all men must die"
    And I press enter in "q"
    And I see the link "Valar Morghulis"

  Scenario: Paginate search results
    Given there are 22 pages titled "Stark's Words"
    When I fill in "q" with "stark"
    And I press enter in "q"
    Then I see 3 pages
    And I see 10 search results
    And I see 2 search results in the page 3
