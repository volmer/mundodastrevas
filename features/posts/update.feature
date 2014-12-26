Feature: Update post
  In order to keep my post up-to-date
  As an user
  I want to edit and change its content

  Background:
    Given I am signed in
    And I have a post called "Davos"

  Scenario: Successfully update a post
    When I go to the "Davos" post
    And I click on "Editar"
    And I fill in "Nome" with "A Storm of Swords"
    And I fill in "URL amigável" with "a-storm-of-swords"
    And I fill in "Conteúdo" with "Fire and Blood."
    And I attach the file "my_image.jpg" to "Imagem"
    And I fill in "Tags" with "medieval, fantasy"
    And I click on "Atualizar post"
    Then I see the info message "Post atualizado!"
    And I see "A Storm of Swords" on the page
    And I see "Fire and Blood" on the page
    And I see "medieval" on the page
    And I see "fantasy" on the page
