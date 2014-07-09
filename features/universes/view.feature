Feature: View universes
  In order to get started in an universe
  As an user
  I want to read the universe info

  Scenario: Show universe
    Given there is an universe with the following attributes:
      | name    | description  |
      | Vampire | We hunt you! |
    And the "Vampire" universe has ranks with users
    When I open the "Vampire" universe page
    Then I see "Vampire" on the page
    And I see "We hunt you!" on the page
    And I see "Ranks" on the page
