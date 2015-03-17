Feature: Update pages
  In order to keep my pages up-to-date
  As an admin
  I want to edit and change their contents

  Background:
    Given I am signed in
    And I am an admin
    And there is a page with the following data:
      | slug         | title         | content           |
      | starks-words | Stark's Words | Winter is coming. |
    And I am on the admin pages page

  Scenario: Successfully update a page
    When I click on "Stark's Words"
    And I fill in "Título" with "Targaryen's Words"
    And I fill in "URL amigável" with "targaryens-words"
    And I fill in "Content" with "Fire and Blood."
    And I click on "Atualizar página"
    Then I see the info message "Página atualizada."
    And I see "Targaryen's Words" on the page
    And I see "Fire and Blood" on the page
