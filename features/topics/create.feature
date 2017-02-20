Feature: Create topic
  In order to start a discussion
  As an user
  I want to create a topic

  Background:
    Given I am signed in as "volmer"

  Scenario: Successfully create a topic
    When I go to the "Small Council" forum
    And I click on "Novo tópico"
    And I fill in "Nome" with "Our new conspiracy"
    And I fill in "topic_forum_posts_attributes_0_content" with "Let's discuss our next move!"
    And I click on "Criar tópico"
    Then I see the info message "Tópico criado!"
    And I see "Our new conspiracy" on the page
    And I see "Let's discuss our next move" on the page
    And I see "Criado por volmer" on the page
    And I see "1 post" on the page

  Scenario Outline: Create a topic without a required field
    When I go to the "Small Council" forum
    And I click on "Novo tópico"
    And I fill in "Nome" with "<Name>"
    And I fill in "topic_forum_posts_attributes_0_content" with "<Content>"
    And I click on "Criar tópico"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "<Invalid field>" with the error "não pode ficar em branco"

    Examples:
      | Name                | Content                      | Invalid field             |
      |                     | Let's discuss our next move! | topic_name                |
      | Our next conspiracy |                              | topic_forum_posts_content |
