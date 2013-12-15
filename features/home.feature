Feature: Home page
  In order to start navigating
  As a user
  I want to access the home page

  Scenario: Access the home page
    When I go to the root page
    Then I see "Nos fóruns" on the page
    And I see "Posts recentes" on the page
    And I see "Comentários" on the page
