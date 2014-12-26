Feature: Destroy zines
  In order to eliminate an unnecessary zine
  As an user
  I want to destroy my zines

  Background:
    Given I am signed in
    And I have a zine with the given attributes:
      | slug         | name          | description       |
      | starks-words | Stark's Words | Winter is coming. |
    And I am on the root page

  Scenario: Successfully destroy a zine
    When I go to the "Stark's Words" zine
    And I click on "Editar"
    And I click on "Apagar zine"
    Then I see the info message "Zine apagado."
    And I don't see "Stark's Words" on the page
