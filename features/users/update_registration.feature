Feature: Update registration
  In order to keep my account information up-to-date
  As a user
  I want to update my registration

  Background:
    Given I am signed in

  Scenario: update name
    When I open my user menu
    And I click on "Configurações"
    And I fill in "Nome" with "volmer"
    And I press "Atualizar"
    Then I am redirected to my user page
    And I see the info message "Você atualizou sua conta com sucesso."
    And I see "volmer" on the page

  Scenario: update email
    Given my email address is "volmer@example.com"
    When I open my user menu
    And I click on "Configurações"
    And I fill in "Email" with "mynewemail@example.com"
    And I press "Atualizar"
    Then I am redirected to my user page
    And I see the following info message:
      """
      Você atualizou sua conta, mas precisamos verificar seu novo endereço de
      email. Por favor, acesse seu email e clique no link de confirmação para
      finalizar a atualização da sua conta.
      """
    And I see the field "Email" with the value "volmer@example.com"
    And I see "Aguardando confirmação para mynewemail@example.com" on the page

  Scenario: update bio
    When I open my user menu
    And I click on "Configurações"
    And I fill in "Bio" with the following text:
      """
      Night gathers, and now my watch begins. It shall not end until my death.
      I shall take no wife, hold no lands, father no children. I shall wear no
      crowns and win no glory. I shall live and die at my post.
      """
    And I press "Atualizar"
    Then I am redirected to my user page
    And I see the info message "Você atualizou sua conta com sucesso."
    And I see the following content on the page:
      """
      Night gathers, and now my watch begins. It shall not end until my death.
      I shall take no wife, hold no lands, father no children. I shall wear no
      crowns and win no glory. I shall live and die at my post.
      """

  Scenario Outline: update gender
    When I open my user menu
    And I click on "Configurações"
    And for "Sexo" I choose "<gender>"
    And I press "Atualizar"
    Then I am redirected to my user page
    And I see the info message "Você atualizou sua conta com sucesso."
    And I see the field "Sexo" with the value "<gender>"

    Examples:
      | gender    |
      | Masculino |
      | Feminino  |

  Scenario: update avatar
    When I open my user menu
    And I click on "Configurações"
    And I attach the file "my_image.jpg" to "Avatar"
    And I press "Atualizar"
    Then I am redirected to my user page
    And I see the info message "Você atualizou sua conta com sucesso."
    And I see the image "my_image.jpg" as my avatar


  Scenario Outline: update other fields
    When I open my user menu
    And I click on "Configurações"
    And I fill in "<field>" with "<value>"
    And I press "Atualizar"
    Then I am redirected to my user page
    And I see the info message "Você atualizou sua conta com sucesso."
    And I see the field "<field>" with the value "<value>"

    Examples:
      | field              | value      |
      | Data de nascimento | 20/09/1980 |
      | Localização        | Winterfell |

