Feature: Watch a post
  In order to get updated about new comments
  As an user
  I want to watch a post

  Background:
    Given I am signed in
    And there is a zine called "A Storm of Swords"
    And within "A Storm of Swords" there is a post called "Arya"
    And I'm on the "Arya" post page

  Scenario: Watch through a form submission
    When I fill in "comment_content" with "Nice post!"
    And I click on "Comentar"
    Then I see the info message "Comentário criado!"
    And the field "Avise-me sobre novos comentários neste post" is checked

  Scenario: Watch throuhg the watch button
    When I click on "Vigiar"
    Then I see the info message "Agora você está vigiando Arya."
    And the field "Avise-me sobre novos comentários neste post" is checked
