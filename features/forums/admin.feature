Feature: List forums in the admin dashboard
  In order to manage forums
  As an admin
  I want to find one or more forums

  Background:
    Given I am signed in
    And I am an admin

  Scenario: List all forums
    Given there is a forum called "The Gathering"
    And there is a forum called "The Wall Facts"
    When I go to the admin root page
    And within the admin tabs I click on "Fóruns"
    Then I see "The Gathering" on the page
    And I see "The Wall Facts" on the page
