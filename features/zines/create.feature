Feature: Create zine
  In order to start publishing my texts
  As an user
  I want to create a zine

  Background:
    Given I am signed in
    And I am on the root page
    And there is an universe called "Vampire"

  Scenario: Successfully create a zine
    When I click on "Zines"
    And I click on "Novo zine"
    And I fill in "Nome" with "A Storm of Swords"
    And I fill in "Url amigável" with "a-storm-of-swords"
    And I fill in "Descrição" with "Fire and Blood."
    And from "Universo" I select "Vampire"
    And I click on "Criar zine"
    Then I see the info message "Zine criado!"
    And I see "Vampire" on the page
