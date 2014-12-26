@javascript
Feature: Review post
  In order to express my opinion
  As an user
  I want to review a post

  Background:
    Given I am signed in
    And there is a post called "Daenerys"

  Scenario: Create positive review
    When I go to the "Daenerys" post
    And I check the post as "loved"
    Then I see "1" in the "loved" post counter
    And I see "0" in the "hated" post counter

  Scenario: Create negative review
    When I go to the "Daenerys" post
    And I check the post as "hated"
    Then I see "0" in the "loved" post counter
    And I see "1" in the "hated" post counter
