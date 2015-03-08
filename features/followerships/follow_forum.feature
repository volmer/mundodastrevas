Feature: Follow a forum
  In order to get up-to-date about a forum
  As a user
  I want to follow a forum

  Background:
    Given I am signed in
    And there is a forum called "The Small Council"

  Scenario: Follow a forum
    When I go to the "The Small Council" forum
    And I click on "Seguir"
    Then I am redirected to "The Small Council" forum
    And I see the info message "Agora você segue The Small Council."

  Scenario: Unfollow a forum
    Given I am following the "The Small Council" forum
    When I go to the "The Small Council" forum
    And I click on "Deixar de seguir"
    Then I am redirected to "The Small Council" forum
    And I see the info message "Você parou de seguir The Small Council."
