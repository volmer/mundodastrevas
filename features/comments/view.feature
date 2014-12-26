Feature: View comments
  In order to follow the discussion line
  As an user or a guest
  I want to view comments in a post

  Background:
    Given there is a zine called "A Storm of Swords"
    And within "A Storm of Swords" there is a post called "Arya"

  Scenario: View a comment
    Given there is a comment "Great post!" in the "Arya" post
    When I go to the "Arya" post
    Then I see "Great post!" on the page

  Scenario: List comments
    Given there is a comment "Great post!" in the "Arya" post
    And there is a comment "I loved it too!" in the "Arya" post
    When I go to the "Arya" post
    Then I see "Great post!" on the page
    And I see "I loved it too!" on the page
    And I see "Deseja adicionar um comentário? Entre aqui!" on the page
