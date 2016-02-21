Feature: Update topic
  In order to change the topic subject
  As the topic author
  I want to update it

  Background:
    Given I am signed in
    And I've created a topic called "Treason!" in "Small Council"

  Scenario: Successfully update a topic
    When I go to the "Small Council" forum
    And I click on "Treason!"
    And I click on "Editar"
    And I fill in "Nome" with "False alarm"
    And I click on "Atualizar tópico"
    Then I see the info message "Tópico atualizado."
    And I see "False alarm" on the page

  Scenario: Update topic without a name
    When I go to the "Small Council" forum
    And I click on "Treason!"
    And I click on "Editar"
    And I fill in "Nome" with ""
    And I click on "Atualizar tópico"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "topic_name" with the error "não pode ficar em branco"
