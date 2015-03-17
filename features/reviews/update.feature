@javascript
Feature: Update review
  In order to fix mistakes
  As an user
  I want to update my reviews

  Background:
    Given I am signed in
    And there is a post called "Daenerys"

  Scenario: Change review from positive to negative
    Given I've reviewed the post "Daenerys" as positive
    And I go to the "Daenerys" post
    When I check the post as "hated"
    Then I see "0" in the "loved" post counter
    And I see "1" in the "hated" post counter
    And I go to the "Daenerys" post
    And I see "0" in the "loved" post counter
    And I see "1" in the "hated" post counter

  Scenario: Change review from negative to positive
    Given I've reviewed the post "Daenerys" as negative
    And I go to the "Daenerys" post
    When I check the post as "loved"
    Then I see "1" in the "loved" post counter
    And I see "0" in the "hated" post counter
    And I go to the "Daenerys" post
    And I see "1" in the "loved" post counter
    And I see "0" in the "hated" post counter

  Scenario: Attempt to change review from positive to positive
    Given I've reviewed the post "Daenerys" as positive
    And I go to the "Daenerys" post
    When I check the post as "loved"
    Then I see "1" in the "loved" post counter
    And I see "0" in the "hated" post counter
    And I go to the "Daenerys" post
    And I see "1" in the "loved" post counter
    And I see "0" in the "hated" post counter

  Scenario: Attempt to change review from negative to negative
    Given I've reviewed the post "Daenerys" as negative
    And I go to the "Daenerys" post
    When I check the post as "hated"
    Then I see "0" in the "loved" post counter
    And I see "1" in the "hated" post counter
    And I go to the "Daenerys" post
    And I see "0" in the "loved" post counter
    And I see "1" in the "hated" post counter

