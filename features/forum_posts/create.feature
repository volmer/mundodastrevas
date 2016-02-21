Feature: Create forum post
  In order to increment the discussion
  As an user
  I want to post in a topic

  Background:
    Given I am signed in as "Ned"
    And there is a topic called "Treason!" in "Small Council"

  Scenario: Successfully post in a topic
    When I go to the "Small Council" forum
    And I click on "Treason!"
    And I fill in "forum_post_content" with "I told you!"
    And I click on "Postar"
    Then I see the info message "Postado!"
    And I see "I told you!" on the page
    And I see "Você está vigiando este tópico" on the page

  Scenario: Create post with the right page
    Given there are 10 forum posts in the "Treason!" topic
    When I go to the "Small Council" forum
    And I click on "Treason!"
    And I fill in "forum_post_content" with "I told you!"
    And I click on "Postar"
    Then I see the info message "Postado!"
    And I see 2 pages
    And I see "11 postagens" on the page
    And I see "I told you!" on the page

  Scenario: Create post without a content
    When I go to the "Small Council" forum
    And I click on "Treason!"
    And I fill in "forum_post_content" with ""
    And I click on "Postar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "forum_post_content" with the error "não pode ficar em branco"
