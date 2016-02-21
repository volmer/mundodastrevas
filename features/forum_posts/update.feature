@javascript
Feature: Update forum post
  In order to fix possible errors or ideas
  As a forum post author
  I want to update my forum post

  Background:
    Given there is a topic called "Who is your favorite knight?" in "Knights"
    And I am signed in
    And I've posted "Loras S2" in the "Who is your favorite knight?" topic

  Scenario: Successfully update forum post
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    And within my forum post I click on "Editar"
    And within my forum post I fill in "forum_post_content" with "Err... Renly?"
    And I click on "Atualizar post"
    Then I see the info message "Post atualizado!"
    And I see "Err... Renly?" on the page
    And I don't see "Loras S2" on the page

  Scenario: Update forum post with the right page
    Given there are 9 forum posts in the "Who is your favorite knight?" topic
    And I've posted "Another post in page 2!" in the "Who is your favorite knight?" topic
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    And I click on "2"
    And within my forum post I click on "Editar"
    And within my forum post I fill in "forum_post_content" with "Updated my post in page 2!"
    And I click on "Atualizar post"
    Then I see the info message "Post atualizado!"
    And I see "Updated my post in page 2!" on the page
    And I don't see "Another post in page 2!" on the page

  Scenario: Update forum post without a content
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    And within my forum post I click on "Editar"
    And within my forum post I fill in "forum_post_content" with ""
    And I click on "Atualizar post"
    Then I see "Loras S2" on the page
