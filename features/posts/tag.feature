Feature: Tag posts
  In order to categorize my posts
  As an user
  I want to add tags to my posts

  Background:
    Given I am signed in
    And I have a post called "Davos"

  Scenario: Successfully add tags to post
    When I go to the "Davos" post
    And I click on "Editar"
    And I fill in "Tags" with "medieval, fantasy"
    And I click on "Atualizar post"
    Then I see the info message "Post atualizado!"
    And I see "medieval" on the page
    And I see "fantasy" on the page
    And I click on "medieval"
    And I see "Tag: medieval" on the page
    And I see "Davos" on the page
