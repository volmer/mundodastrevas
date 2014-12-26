Feature: Update zine
  In order to keep my zine up-to-date
  As an user
  I want to edit and change its content

  Background:
    Given I am signed in
    And I have a zine with the given attributes:
      | slug             | name             | description       |
      | a-clash-of-kings | A Clash of Kings | Winter is coming. |
    And I am on the root page

  Scenario: Successfully update a zine
    When I go to the "A Clash of Kings" zine
    And I click on "Editar"
    And I fill in "Nome" with "A Storm of Swords"
    And I fill in "URL amigável" with "a-storm-of-swords"
    And I fill in "Descrição" with "Fire and Blood."
    And I click on "Atualizar zine"
    Then I see the info message "Zine atualizado!"
    And I see "A Storm of Swords" on the page
    And I see "Fire and Blood" on the page
