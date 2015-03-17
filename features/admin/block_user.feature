Feature: Block user
  In order to avoid scumbags
  As an admin
  I want to block and unblock users

  Background:
    Given I am signed in
    And I am an admin
    And there is an user called "theon"

  Scenario: Block an user
    When I go to the admin users page
    And I click on "theon"
    And for "Estado" I choose "Bloqueado"
    And I click on "Salvar"
    Then I see the info message "As configurações para theon foram atualizadas com sucesso."
    And the field "Bloqueado" is checked

  Scenario: Unblock an user
    Given "theon" is blocked
    When I go to the admin users page
    And I click on "theon"
    And for "Estado" I choose "Ativo"
    And I click on "Salvar"
    Then I see the info message "As configurações para theon foram atualizadas com sucesso."
    And the field "Ativo" is checked
