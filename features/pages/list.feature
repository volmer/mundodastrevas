Feature: List pages
  In order to manage pages
  As an admin
  I want to find one or more pages

  Background:
    Given I am signed in
    And I am an admin

  Scenario: List all pages
    Given there is a page titled "Baratheon's Words"
    And there is a page titled "Bolton's Words"
    When I go to the admin root page
    And I click on "Páginas"
    Then I see "Baratheon's Words" on the page
    And I see "Bolton's Words" on the page

  Scenario: Paginate pages
    Given there are 22 pages
    When I go to the admin pages page
    Then I see 3 pages
    And I see 10 pages listed
    And I see 2 pages listed in the page 3
