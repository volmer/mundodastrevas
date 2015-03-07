Feature: Destroy forum post
  In order to get rid of shameful words
  As a forum post author
  I want to destroy my

  Background:
    Given there is a topic called "Who is your favorite knight?" in the "Knights" forum
    And I am signed in
    And I've posted "Loras S2" in the "Who is your favorite knight?" topic

  Scenario: Successfully destroy forum post
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    And within my forum post I click on "Apagar"
    Then I see the info message "Post apagado."
    And I don't see "Loras S2" on the page
