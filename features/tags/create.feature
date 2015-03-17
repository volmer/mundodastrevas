Feature: Create tags
  In order to categorize my items
  As an user
  I want to create tags

  Background:
    Given I am signed in
    And I'm on the new post page

  Scenario: Add tags at post creation
    When I fill in "Nome" with "My post title"
    And I fill in "Conteúdo" with "My post"
    And I fill in "URL amigável" with "my-post"
    And I fill in "Tags" with "fantasy, fiction"
    And I click on "Criar post"
    Then I see "My post" on the page
    And I see "fantasy" on the page
    And I see "fiction" on the page

  Scenario: Persist tags added in post validation
    When I fill in "Tags" with "fantasy, fiction"
    And I click on "Criar post"
    Then I see "não pode ficar em branco" on the page
    And I see the field "Tags" filled in with "fantasy, fiction"

  Scenario: Tags are optional
    When I fill in "Nome" with "My post title"
    And I fill in "Conteúdo" with "My post"
    And I fill in "URL amigável" with "my-post"
    And I click on "Criar post"
    Then I see "My post" on the page

  Scenario: Add tags at post update
    Given I'm on the edit post page
    And I fill in "Tags" with "medieval, gothic"
    And I click on "Atualizar post"
    Then I see "medieval" on the page
    And I see "gothic" on the page

  Scenario: Remove tags
    When I fill in "Nome" with "My post title"
    And I fill in "Conteúdo" with "My post"
    And I fill in "URL amigável" with "my-post"
    And I fill in "Tags" with "fantasy, fiction"
    And I click on "Criar post"
    And I click on "Editar"
    And I fill in "Tags" with ""
    And I click on "Atualizar post"
    Then I don't see "fantasy" on the page
    And I don't see "fiction" on the page

  Scenario: Change tags
    When I fill in "Nome" with "My post title"
    And I fill in "Conteúdo" with "My post"
    And I fill in "URL amigável" with "my-post"
    And I fill in "Tags" with "fantasy, fiction"
    And I click on "Criar post"
    And I click on "Editar"
    And I fill in "Tags" with "fiction, medieval"
    And I click on "Atualizar post"
    Then I see "fiction" on the page
    And I see "medieval" on the page
    And I don't see "fantasy" on the page
