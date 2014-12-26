Feature: Display followerships
  In order to meet new users and zines
  As a user
  I want to know who follows whom zines

  Background:
    Given I am signed in as "volmer"
    And there is a zine called "A Game of Thrones"
    And I am following the "A Game of Thrones" zine

  Scenario: View followers
    When I go to the "A Game of Thrones" zine
    And I click on "Seguidor"
    Then I see "volmer" on the page

  Scenario: View following
    When I go to my profile page
    And I click on "Seguindo"
    Then I see "A Game of Thrones" on the page
