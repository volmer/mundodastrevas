Feature: Destroy post
  In order to eliminate an unnecessary post
  As an user
  I want to destroy my post

  Background:
    Given I am signed in
    And I have a post called "Davos"

  Scenario: Successfully destroy a zine
    When I go to the "Davos" post
    And I click on "Editar"
    And I click on "Apagar post"
    Then I see the info message "Post apagado."
    And I don't see "Davos" on the page
