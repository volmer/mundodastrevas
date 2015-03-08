Feature: Display forum followerships
  In order to meet new users and forums
  As a user
  I want to know who follows whom forums

  Background:
    Given I am signed in as "volmer"
    And there is a forum called "The Small Council"
    And I am following the "The Small Council" forum

  Scenario: View followers
    When I go to the "The Small Council" forum
    And I click on "Seguidor"
    Then I see "volmer" on the page

  Scenario: View following
    When I go to my profile page
    And I click on "Seguindo"
    Then I see "The Small Council" on the page
