Feature: Set admin
  In order to share the load
  As an admin
  I want to set some users as admins

  Background:
    Given I am signed in
    And I am an admin
    And there is an user called "ned"

  Scenario: Promote to admin
    When I go to the admin users page
    And I click on "ned"
    And I check "Admin"
    And I click on "Salvar"
    Then I see the info message "As configurações para ned foram atualizadas com sucesso."
    And the field "Admin" is checked

  Scenario: Remove the admin role
    Given "ned" is an admin
    When I go to the admin users page
    And I click on "ned"
    And I uncheck "Admin"
    And I click on "Salvar"
    Then I see the info message "As configurações para ned foram atualizadas com sucesso."
    And the field "Admin" is not checked
