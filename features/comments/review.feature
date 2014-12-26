@javascript
Feature: Review comment
  In order to express my opinion
  As an user
  I want to review a comment

  Background:
    Given there is a zine called "A Storm of Swords"
    And within "A Storm of Swords" there is a post called "Arya"
    And I am signed in
    And there is a comment "Great post!" in the "Arya" post
    And I'm on the "Arya" post page

  Scenario: Create positive review
    And I check the comment as "loved"
    Then I see "1" in the "loved" comment counter
    And I see "0" in the "hated" comment counter

  Scenario: Create negative review
    And I check the comment as "hated"
    Then I see "0" in the "loved" comment counter
    And I see "1" in the "hated" comment counter
