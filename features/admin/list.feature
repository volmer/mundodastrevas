Feature: List zines in the admin dashboard
  In order to manage zines
  As an admin
  I want to find one or more zines

  Background:
    Given I am signed in
    And I am an admin

  Scenario: List all zines
    Given there is a zine called "A Song of Ice and Fire"
    And there is a zine called "The Lands of Ice and Fire"
    When I go to the admin root page
    And within the admin tabs I click on "Zines"
    Then I see "A Song of Ice and Fire" on the page
    And I see "The Lands of Ice and Fire" on the page

  Scenario: Paginate zines
    Given there are 42 zines
    When I go to the admin root page
    And within the admin tabs I click on "Zines"
    Then I see 3 pages
    And I see 20 zines
    And I see 2 zines in the page 3
