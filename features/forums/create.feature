Feature: Create forums
  In order to let users start related discussions
  As an admin
  I want to create forums

  Background:
    Given I am signed in
    And I am an admin
    And I am on the admin root page

  Scenario: Successfully create a forum
    When within the admin tabs I click on "Fóruns"
    And I click on "Novo fórum"
    And I fill in "Nome" with "Targaryen's Words"
    And I fill in "Url amigável" with "targaryens-words"
    And I fill in "Descrição" with "Fire and Blood."
    And I click on "Criar fórum"
    Then I see the info message "Fórum criado!"
    And I see "Targaryen's Words" on the page
    And I see "Fire and Blood" on the page

  Scenario Outline: Create a forum without a required field
    When within the admin tabs I click on "Fóruns"
    And I click on "Novo fórum"
    And I fill in "Nome" with "<Name>"
    And I fill in "Url amigável" with "<Slug>"
    And I fill in "Descrição" with "<Description>"
    And I click on "Criar fórum"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "<Invalid field>" with the error "não pode ficar em branco"

    Examples:
      | Name              | Slug             | Description    | Invalid field     |
      |                   | targaryens-words | Fire and Blood | forum_name        |
      | Targaryen's Words |                  | Fire and Blood | forum_slug        |
      | Targaryen's Words | targaryens-words |                | forum_description |

  Scenario Outline: Create forum with a valid slug
    When within the admin tabs I click on "Fóruns"
    And I click on "Novo fórum"
    And I fill in "Url amigável" with "<Slug>"
    And I click on "Criar fórum"
    Then I see no errors in the field "Url amigável"

    Examples:
      | Slug             |
      | targaryen        |
      | TARGARYEN        |
      | targaryens-words |
      | targaryen-123    |

  Scenario Outline: Create forum with an invalid slug
    When within the admin tabs I click on "Fóruns"
    And I click on "Novo fórum"
    And I fill in "Url amigável" with "<Slug>"
    And I click on "Criar fórum"
    And I see the danger message "Verifique os erros abaixo:"
    And I see the field "forum_slug" with the error "não é válido"

    Examples:
      | Slug              |
      | targayen's-words  |
      | targaryens words  |
      | targaryen.s-words |
      | targáriens-words  |

  Scenario: Create forum with a slug already in use
    Given there is a forum with the given attributes:
      | slug             |
      | targaryens-words |
    When within the admin tabs I click on "Fóruns"
    And I click on "Novo fórum"
    And I fill in "Url amigável" with "targaryens-words"
    And I click on "Criar fórum"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "forum_slug" with the error "já está em uso"

