@javascript
Feature: Quote forum post
  In order to answer another user
  As an user
  I want to quote a forum post in my new forum post

  Background:
    Given there is a topic called "Who is your favorite knight?" in "Knights"
    And I am signed in
    And there is a forum post "Loras S2" in the "Who is your favorite knight?" topic

  Scenario: Quote forum post
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    And within the forum post I click on "Citar"
    Then I see "Loras S2" in the editor
