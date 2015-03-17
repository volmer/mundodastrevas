Feature: Unwatch an item
  In order to stop receiving undesirable notifications
  As an user
  I want to unwatch an item

  Background:
    Given I am signed in
    And there is a zine called "A Storm of Swords"
    And within "A Storm of Swords" there is a post called "Arya"
    And I am watching the post
    And I'm on the "Arya" post page

  Scenario: Unwatch through a form submission
    When I fill in "comment_content" with "My comment"
    And I uncheck "Avise-me sobre novos comentários neste post"
    And I click on "Comentar"
    Then I see "My comment" on the page
    And the field "Avise-me sobre novos comentários neste post" is not checked

  Scenario: Unatch throuhg the watch button
    When I click on "Parar de vigiar"
    Then I see the info message "Você parou de vigiar Arya."
    And the field "Avise-me sobre novos comentários neste post" is not checked
