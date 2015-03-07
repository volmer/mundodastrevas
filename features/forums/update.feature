Feature: Update forums
  In order to keep my forums up-to-date
  As an admin
  I want to edit and change their contents

  Background:
    Given I am signed in
    And I am an admin
    And there is a forum with the given attributes:
      | slug         | name          | description       |
      | starks-words | Stark's Words | Winter is coming. |
    And I am on the admin forums page

  Scenario: Successfully update a forum
    When I click on "Stark's Words"
    And I fill in "Nome" with "Targaryen's Words"
    And I fill in "Url amigável" with "targaryens-words"
    And I fill in "Descrição" with "Fire and Blood."
    And I click on "Atualizar fórum"
    Then I see the info message "Fórum atualizado."
    And I see "Targaryen's Words" on the page
    And I see "Fire and Blood" on the page
