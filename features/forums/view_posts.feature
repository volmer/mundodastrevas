Feature: View posts
  In order to follow the discussion line
  As an user or a guest
  I want to view posts in a topic

  Background:
    Given there is a topic called "Who is your favorite knight?" in the "Knights" forum

  Scenario: View a post
    Given there is a post "Bronn!" in the "Who is your favorite knight?" topic
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    Then I see "Bronn!" on the page
