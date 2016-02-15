Feature: Privacy settings
  In order to keep my data private or public
  As a user
  I want to set my privacy settings

  Background:
    Given I am signed up with the following data:
      | name     | email               | gender | bio                  | location   | birthday   |
      | catelyn  | catelyn@example.com | female | Duty, family, honor. | Winterfell | 1959-05-22 |
    And I am signed in
    And I am on the edit user registration page

  Scenario Outline: Set a data as public
    When I click on "Opções de privacidade"
    And from "<field>" I select "Público"
    And I click on "Salvar"
    Then I am redirected to the edit user privacy page
    And I see the info message "Suas preferências foram atualizadas."
    And the select "<field>" is set to "Público"
    And I can see my "<field>"
    And the user "volmer" can see my "<field>"

    Examples:
      | field              |
      | Email              |
      | Sexo               |
      | Localização        |
      | Data de nascimento |

  Scenario Outline: Set a data as private
    When I click on "Opções de privacidade"
    And from "<field>" I select "Somente eu"
    And I click on "Salvar"
    Then I am redirected to the edit user privacy page
    And I see the info message "Suas preferências foram atualizadas."
    And the select "<field>" is set to "Somente eu"
    And I can see my "<field>"
    And the user "volmer" cannot see my "<field>"

    Examples:
      | field              |
      | Email              |
      | Sexo               |
      | Localização        |
      | Data de nascimento |

  Scenario Outline: Default values are public
    When I click on "Opções de privacidade"
    Then the select "<field>" is set to "Público"
    And the user "volmer" can see my "<field>"

    Examples:
      | field              |
      | Email              |
      | Sexo               |
      | Localização        |
      | Data de nascimento |

  Scenario Outline: Set an external account as public
    Given I've connected my <provider> account
    When I click on "Opções de privacidade"
    And from "<provider>" I select "Público"
    And I click on "Salvar"
    Then I am redirected to the edit user privacy page
    And I see the info message "Suas preferências foram atualizadas."
    And I can see the link "<provider>" in my profile page
    And the user "volmer" can see the link "<provider>" in my profile page

    Examples:
      | provider |
      | Facebook |

  Scenario Outline: Set an external account as private
    Given I've connected my <provider> account
    When I click on "Opções de privacidade"
    And from "<provider>" I select "Somente eu"
    And I click on "Salvar"
    Then I am redirected to the edit user privacy page
    And I see the info message "Suas preferências foram atualizadas."
    And I can see the link "<provider>" in my profile page
    And the user "volmer" cannot see the link "<provider>" in my profile page

    Examples:
      | provider |
      | Facebook |
