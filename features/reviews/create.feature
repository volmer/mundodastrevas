@javascript
Feature: Create review
  In order to express my opinion
  As an user
  I want to review an item

  Background:
    Given I am signed in as "jorah"
    And there is a post called "Daenerys"
    And I go to the "Daenerys" post

  Scenario: Create positive review
    When I check the post as "loved"
    Then I see "1" in the "loved" post counter
    And I see "0" in the "hated" post counter
    And I go to the "Daenerys" post
    And I see "1" in the "loved" post counter
    And I see "0" in the "hated" post counter
    And I go to my profile page
    And I see "jorah curtiu Daenerys" on the page

  Scenario: Create negative review
    When I check the post as "hated"
    Then I see "0" in the "loved" post counter
    And I see "1" in the "hated" post counter
    And I go to the "Daenerys" post
    And I see "0" in the "loved" post counter
    And I see "1" in the "hated" post counter
    And I go to my profile page
    And I don't see "Awesome post" on the page
