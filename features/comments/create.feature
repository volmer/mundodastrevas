Feature: Create comment
  In order to express my opinion about a post
  As an user
  I want to create a comment

  Background:
    Given I am signed in as "volmer"
    And I have a zine called "A Storm of Swords"
    And within "A Storm of Swords" there is a post called "Arya"
    And I'm on the "Arya" post page

  Scenario: Successfully create a comment
    When I fill in "comment_content" with "Great post!"
    And I click on "Comentar"
    Then I see the info message "Comentário criado!"
    And I see "A Storm of Swords" on the page
    And I see "Arya" on the page
    And I see "Great post!" on the page

  Scenario: Create a comment without a content
    When I fill in "comment_content" with ""
    And I click on "Comentar"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "comment_content" with the error "não pode ficar em branco"
