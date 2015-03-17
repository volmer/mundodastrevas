Feature: Criar páginas
  In order to publish important contents
  As an admin
  I want to create pages

  Background:
    Given I am signed in
    And I am an admin
    And I am on the admin pages page

  Scenario: Successfully create a page
    When I click on "Páginas"
    And I click on "Nova página"
    And I fill in "Título" with "Targaryen's Words"
    And I fill in "URL amigável" with "targaryens-words"
    And I fill in "Content" with "Fire and Blood."
    And I click on "Criar página"
    Then I see the info message "Página criada!"
    And I see "Targaryen's Words" on the page
    And I see "Fire and Blood" on the page

  Scenario Outline: Create a page without a required field
    When I click on "Páginas"
    And I click on "Nova página"
    And I fill in "Título" with "<Título>"
    And I fill in "URL amigável" with "<URL amigável>"
    And I fill in "Content" with "<Content>"
    And I click on "Criar página"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "<Invalid field>" with the error "não pode ficar em branco"

    Examples:
      | Título            | URL amigável     | Content        | Invalid field |
      |                   | targaryens-words | Fire and Blood | Título        |
      | Targaryen's Words |                  | Fire and Blood | URL amigável  |
      | Targaryen's Words | targaryens-words |                | Content       |

  Scenario Outline: Criar página with a valid slug
    When I click on "Páginas"
    And I click on "Nova página"
    And I fill in "URL amigável" with "<URL amigável>"
    And I click on "Criar página"
    Then I see no errors in the field "URL amigável"

    Examples:
      | URL amigável     |
      | targaryen        |
      | TARGARYEN        |
      | targaryens-words |
      | targaryen-123    |

  Scenario Outline: Criar página with an invalid slug
    When I click on "Páginas"
    And I click on "Nova página"
    And I fill in "URL amigável" with "<URL amigável>"
    And I click on "Criar página"
    And I see the danger message "Verifique os erros abaixo:"
    And I see the field "URL amigável" with the error "não é válido"

    Examples:
      | URL amigável      |
      | targayen's-words  |
      | targaryens words  |
      | targaryen.s-words |
      | targáriens-words  |

  Scenario: Criar página with a slug already in use
    Given there is a page with the following data:
      | slug             |
      | targaryens-words |
    When I click on "Páginas"
    And I click on "Nova página"
    And I fill in "URL amigável" with "targaryens-words"
    And I click on "Criar página"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "URL amigável" with the error "já está em uso"

