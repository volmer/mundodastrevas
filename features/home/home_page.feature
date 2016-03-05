Feature: Home Page
  In order to start navigating
  As a user
  I want to access the home page

  Scenario: Access the home page
    When I go to the root page
    Then I see "Mundo das Trevas" on the page
    And I see the link "Mais zines"
    And I see the link "Mais fóruns"
