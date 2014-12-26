Feature: Update zine
  In order to perform administrative tasks on zines
  As an admin
  I want to edit and change a zine

  Background:
    Given I am signed in
    And I am an admin

  Scenario: Star a zine
    Given there is a zine called "A Song of Ice and Fire"
    When I go to the admin root page
    And within the admin tabs I click on "Zines"
    And I click on "A Song of Ice and Fire"
    And I check "Estrelado"
    And I click on "Salvar"
    Then I see "Zine atualizado!" on the page
    And I the "A Song of Ice and Fire" zine is starred
