@javascript
Feature: Review forum post
  In order to express my opinion
  As an user
  I want to review a forum post

  Background:
    Given there is a topic called "Who is your favorite knight?" in the "Knights" forum
    And I am signed in
    And there is a forum post "Loras S2" in the "Who is your favorite knight?" topic

  Scenario: Create positive review
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    And I check the forum post as "loved"
    Then I see "1" in the "loved" forum post counter
    And I see "0" in the "hated" forum post counter

  Scenario: Create negative review
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    And I check the forum post as "hated"
    Then I see "0" in the "loved" forum post counter
    And I see "1" in the "hated" forum post counter
