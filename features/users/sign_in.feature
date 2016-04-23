Feature: User sign in
  In order to get access to protected sections
  As an user
  I want to be able to sign in

  Background:
    Given I am signed up with the following data:
      | name   | email              | password |
      | volmer | volmer@example.com | 12345678 |
    And I am not signed in
    And I go to the new user session page

  Scenario: Successfull sign in
    When I fill in "Email" with "volmer@example.com"
    And I fill in "Senha" with "12345678"
    And I check "Lembrar"
    And I press "Entrar"
    Then I am redirected to the root page
    And I am successfully signed in as "volmer"
    And I see the info message "Agora você está logado, bem-vindo!"

  Scenario: Sign in with invalid password
    When I fill in "Email" with "volmer@example.com"
    And I fill in "Senha" with "11111111"
    And I press "Entrar"
    Then I see the danger message "Email ou senha inválidos."

  Scenario: Sign in with invalid email
    When I fill in "Email" with "vol@example.com"
    And I fill in "Senha" with "12345678"
    And I press "Entrar"
    Then I see the danger message "Email ou senha inválida."

  Scenario: A blocked user attempts to sign in
    Given I am blocked
    When I fill in "Email" with "volmer@example.com"
    And I fill in "Senha" with "12345678"
    And I press "Entrar"
    And I see the danger message "Sua conta está bloqueada. Entre em contato conosco."
