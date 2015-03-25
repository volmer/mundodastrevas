@javascript
Feature: Admin
  In order to perform administrative actions
  As an administrator
  I want to access the admin dashboard

  Scenario: Access the dashboard as an admin user
    Given I am signed in as "volmer"
    And I am an admin
    When I go to the root page
    And I open my user menu
    And I click on "Administração"
    Then I am redirected to the admin root page
    And I see the page heading "Administração"

  Scenario: Access the dashboard as an admin user
    Given I am signed in as "not_admin"
    When I go to the root page
    When I open my user menu
    Then I don't see "Administração" on the page

