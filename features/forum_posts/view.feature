Feature: View forum posts
  In order to follow the discussion line
  As an user or a guest
  I want to view forum posts in a topic

  Background:
    Given there is a topic called "Who is your favorite knight?" in "Knights"

  Scenario: View a forum post
    Given there is a forum post "Bronn!" in the "Who is your favorite knight?" topic
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    Then I see "Bronn!" on the page

  Scenario: List forum post
    Given there is a forum post "Brienne!" in the "Who is your favorite knight?" topic
    And there is a forum post "Bronn!" in the "Who is your favorite knight?" topic
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    Then I see "Brienne!" on the page
    And I see "Bronn!" on the page
