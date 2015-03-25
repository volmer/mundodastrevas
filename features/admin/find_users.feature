Feature: Find users
  In order to manage users
  As an admin
  I want to find one or more users

  Background:
    Given I am signed in as "volmer"
    And I am an admin

  Scenario: List all users
    Given there is an user called "arya"
    And there is an user called "robb"
    When I go to the admin root page
    And I click on "Usuários"
    Then I see "arya" on the page
    And I see "robb" on the page
    And I see "volmer" on the page

  Scenario: Paginate users
    Given there are 25 users
    When I go to the admin users page
    Then I see 2 pages
    And I see 20 users
    And I see 6 users in the page 2
