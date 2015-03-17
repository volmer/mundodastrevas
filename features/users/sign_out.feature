@javascript
Feature: User sign out
  In order to protect my account from unauthorized access
  As an user
  I want to be able to sign out

  Scenario: Successful sign out
    Given I am signed in as "volmer"
    When I open my user menu
    And I click on "Sair"
    Then I am redirected to the root page
    And I see the info message "Você não está mais logado."
