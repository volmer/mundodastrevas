Feature: Email preferences
  In order to not have my email inbox flooded
  As a user
  I want to disable unwanted emails

  Background:
    Given I am signed in
    And I am on the edit user registration page

  Scenario Outline: Disable emails
    When I click on "Preferências de email"
    And I uncheck "<field>"
    And I click on "Salvar"
    Then I am redirected to the edit user email preferences page
    And I see the info message "Suas preferências de email foram atualizadas."
    And the field "<field>" is not checked

    Examples:
      | field            |
      | Novos seguidores |
      | Novas mensagens  |

  Scenario Outline: Enable emails
    When I click on "Preferências de email"
    And I check "<field>"
    And I click on "Salvar"
    Then I am redirected to the edit user email preferences page
    And I see the info message "Suas preferências de email foram atualizadas."
    And the field "<field>" is checked

    Examples:
      | field            |
      | Novos seguidores |
      | Novas mensagens  |

  Scenario Outline: Emails are enabled by default
    When I click on "Preferências de email"
    Then the field "<field>" is checked

    Examples:
      | field            |
      | Novos seguidores |
      | Novas mensagens  |

