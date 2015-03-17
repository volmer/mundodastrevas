Feature: Follow a user
  In order to get up-to-date about another user
  As a user
  I want to follow another user

  Background:
    Given I am signed in as "ned"
    And there is an user called "catelyn"

  Scenario: Follow catelyn
    When I go to catelyn's profile page
    And I click on "Seguir"
    Then I am redirected to catelyn's profile page
    And I see the info message "Agora você segue catelyn."
    And I go to my profile page
    And I see an activity called "ned começou a seguir catelyn"

  Scenario: Unfollow catelyn
    Given I am following catelyn
    When I go to catelyn's profile page
    And I click on "Deixar de seguir"
    Then I am redirected to catelyn's profile page
    And I see the info message "Você parou de seguir catelyn."

  Scenario: catelyn starts following me
    When catelyn starts following me
    And I go to the root page
    And I open the notifications menu
    Then I see "catelyn está te seguindo" on the page
    And I receive an email titled "catelyn começou a te seguir!"

  Scenario: catelyn starts following me, but I don't want to receive an email about this
    Given I've unchecked "Novos seguidores" in my email preferences
    When catelyn starts following me
    And I go to the root page
    And I open the notifications menu
    Then I see "catelyn está te seguindo" on the page
    And I don't receive an email titled "catelyn começou a te seguir!"
