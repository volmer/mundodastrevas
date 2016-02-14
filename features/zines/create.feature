Feature: Create zine
  In order to start publishing my texts
  As an user
  I want to create a zine

  Background:
    Given I am signed in as "georgerrmartin"
    And I am on the root page

  Scenario: Successfully create a zine
    Given there is an universe called "A Song of Ice and Fire"
    When I click on "Zines"
    And I click on "Novo zine"
    And I fill in "Nome" with "A Storm of Swords"
    And I fill in "URL amigável" with "a-storm-of-swords"
    And I fill in "Descrição" with "Fire and Blood."
    And from "Universo" I select "A Song of Ice and Fire"
    And I attach the file "my_image.jpg" to "Imagem"
    And I click on "Criar zine"
    Then I see the info message "Zine criado!"
    And I see "A Storm of Swords" on the page
    And I see "Fire and Blood" on the page
    And I see the image "my_image.jpg"

  Scenario Outline: Create a zine without a required field
    When I click on "Zines"
    And I click on "Novo zine"
    And I fill in "Nome" with "<Name>"
    And I fill in "URL amigável" with "<Slug>"
    And I fill in "Descrição" with "<Description>"
    And I click on "Criar zine"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "<Invalid field>" with the error "não pode ficar em branco"

    Examples:
      | Name              | Slug              | Description    | Invalid field    |
      |                   | a-storm-of-swords | Fire and Blood | zine_name        |
      | A Storm of Swords |                   | Fire and Blood | zine_slug        |
      | A Storm of Swords | a-storm-of-swords |                | zine_description |

  Scenario Outline: Create zine with a valid slug
    When I click on "Zines"
    And I click on "Novo zine"
    And I fill in "URL amigável" with "<Slug>"
    And I click on "Criar zine"
    Then I see no errors in the field "URL amigável"

    Examples:
      | Slug             |
      | targaryen        |
      | TARGARYEN        |
      | targaryens-words |
      | targaryen-123    |

  Scenario Outline: Create zine with an invalid slug
    When I click on "Zines"
    And I click on "Novo zine"
    And I fill in "URL amigável" with "<Slug>"
    And I click on "Criar zine"
    And I see the danger message "Verifique os erros abaixo:"
    And I see the field "zine_slug" with the error "não é válido"

    Examples:
      | Slug              |
      | targayen's-words  |
      | targaryens words  |
      | targaryen.s-words |
      | targáriens-words  |

  Scenario: Create zine with a slug already in use
    Given there is a zine with the given attributes:
      | slug              |
      | a-storm-of-swords |
    When I click on "Zines"
    And I click on "Novo zine"
    And I fill in "URL amigável" with "A-Storm-Of-Swords"
    And I click on "Criar zine"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "zine_slug" with the error "já está em uso"
