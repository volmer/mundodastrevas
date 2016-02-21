Feature: Destroy topic
  In order to get rid of my shame
  As the topic author
  I want to destroy a topic

  Background:
    Given I am signed in
    And I've created a topic called "Joffrey is a bastard" in "Small Council"

  Scenario: Destroy a topic
    When I go to the "Small Council" forum
    And I click on "Joffrey is a bastard"
    And I click on "Editar"
    And I click on "Apagar tópico"
    Then I see the info message "Tópico apagado."
    And I don't see "Joffrey is a bastard" on the page
