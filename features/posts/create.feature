Feature: Create post
  In order to publish a text
  As an user
  I want to create a post

  Background:
    Given I am signed in as "georgerrmartin"
    And I have a zine called "A Storm of Swords"
    And I'm on the "A Storm of Swords" zine page

  Scenario: Successfully create a post
    When I click on "Novo post"
    And I fill in "Nome" with "Chapter 1 - Davos"
    And I fill in "URL amigável" with "davos"
    And I fill in "Conteúdo" with "Davos is a good guy."
    And I attach the file "my_image.jpg" to "Imagem"
    And I fill in "Tags" with "medieval, gothic"
    And I click on "Criar post"
    Then I see the info message "Post criado!"
    And I see "A Storm of Swords" on the page
    And I see "Chapter 1 - Davos" on the page
    And I see "Davos is a good guy." on the page
    And I see the image "my_image.jpg"
    And I see "medieval" on the page
    And I see "gothic" on the page

  Scenario Outline: Create a post without a required field
    When I click on "Novo post"
    And I fill in "Nome" with "<Name>"
    And I fill in "Conteúdo" with "<Content>"
    And I click on "Criar post"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "<Invalid field>" with the error "não pode ficar em branco"

    Examples:
      | Name              | Content              | Invalid field|
      |                   | Davos is a good guy. | post_name    |
      | Chapter 1 - Davos |                      | post_content |

  Scenario Outline: Create post with a valid slug
    When I click on "Novo post"
    And I fill in "URL amigável" with "<Slug>"
    And I click on "Criar post"
    Then I see no errors in the field "URL amigável"

    Examples:
      | Slug             |
      | targaryen        |
      | TARGARYEN        |
      | targaryens-words |
      | targaryen-123    |

  Scenario Outline: Create post with an invalid slug
    When I click on "Novo post"
    And I fill in "URL amigável" with "<Slug>"
    And I click on "Criar post"
    And I see the danger message "Verifique os erros abaixo:"
    And I see the field "post_slug" with the error "não é válido"

    Examples:
      | Slug              |
      | targayen's-words  |
      | targaryens words  |
      | targaryen.s-words |
      | targáriens-words  |

  Scenario: Create post with a slug already in use
    Given there is a post with the given attributes:
      | slug  |
      | davos |
    When I click on "Novo post"
    And I fill in "URL amigável" with "davos"
    And I click on "Criar post"
    Then I see the danger message "Verifique os erros abaixo:"
    And I see the field "post_slug" with the error "já está em uso"
