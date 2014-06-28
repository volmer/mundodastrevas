Feature: Set Featured Zine
  In order to make older zines relevant again
  As an administrator
  I want to show a zine in the home page

  Background:
    Given I am signed in
    And I am an admin

  Scenario: Mark zine as featured
    Given there is a zine called "A Feast of Crows"
    When I go to the admin root page
    And within the admin tabs I click on "Zines"
    And I click on "A Feast of Crows"
    And I check "featured"
    And I click on "Salvar"
    And I go to the root page
    Then I see "A Feast of Crows" as the featured zine

  Scenario: Unmark zine as featured
    Given "A Feast of Crows" is the featured zine
    When I go to the admin root page
    And within the admin tabs I click on "Zines"
    And I click on "A Feast of Crows"
    And I uncheck "featured"
    And I click on "Salvar"
    And I go to the root page
    Then there is no featured zine
