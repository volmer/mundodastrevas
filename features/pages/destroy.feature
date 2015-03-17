Feature: Destroy pages
  In order to eliminate unnecessary pages
  As an admin
  I want to destroy particular pages

  Background:
    Given I am signed in
    And I am an admin
    And there is a page with the following data:
      | slug         | title         | content           |
      | starks-words | Stark's Words | Winter is coming. |
    And I am on the admin pages page

  Scenario: Successfully update a page
    When I click on "Stark's Words"
    And I click on "Excluir página"
    Then I am redirected to the admin pages page
    Then I see the info message "Página excluída."
    And I don't see "Stark's Words" on the page
