Feature: Home Page
  In order to begin my awesome experience
  As a user
  I want to navigate through the home page

  Scenario: view the home page
    Given the site calls "Radicaos"
    When I go to the root page
    Then I see "Radicaos" in the page
