Feature: Destroy forums
  In order to eliminate unnecessary forums
  As an admin
  I want to destroy particular forums

  Background:
    Given I am signed in
    And I am an admin
    And there is a forum with the given attributes:
      | slug         | name          | description       |
      | starks-words | Stark's Words | Winter is coming. |
    And I am on the admin forums page

  Scenario: Successfully destroy a forum
    When I click on "Stark's Words"
    And I click on "Apagar fórum"
    Then I am redirected to the admin forums page
    Then I see the info message "Fórum apagado."
    And I don't see "Stark's Words" on the page
