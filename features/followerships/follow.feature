Feature: Follow a zine
  In order to get up-to-date about a zine
  As a user
  I want to follow a zine

  Background:
    Given I am signed in
    And there is a zine called "A Game of Thrones"

  Scenario: Follow a zine
    When I go to the "A Game of Thrones" zine
    And I click on "Seguir"
    Then I am redirected to "A Game of Thrones" zine
    And I see the info message "Agora você segue A Game of Thrones."

  Scenario: Unfollow a zine
    Given I am following the "A Game of Thrones" zine
    When I go to the "A Game of Thrones" zine
    And I click on "Deixar de seguir"
    Then I am redirected to "A Game of Thrones" zine
    And I see the info message "Você parou de seguir A Game of Thrones."
