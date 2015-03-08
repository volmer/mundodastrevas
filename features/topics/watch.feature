Feature: Watch a topic
  In order to get updated about new posts
  As an user
  I want to watch a topic

  Background:
    Given I am signed in
    And there is a topic called "Treason!" in the "Small Council" forum

  Scenario: Watch through a form submission
    When I go to the "Small Council" forum
    And I click on "Treason!"
    And I fill in "forum_post_content" with "I told you!"
    And I click on "Postar"
    Then I see the info message "Postado!"
    And the field "Avise-me sobre novas postagens neste tópico" is checked

  Scenario: Watch throuhg the watch button
    When I go to the "Small Council" forum
    And I click on "Treason!"
    And I click on "Vigiar"
    Then I see the info message "Agora você está vigiando Treason!."
    And the field "Avise-me sobre novas postagens neste tópico" is checked
