Feature: Notify new rank
  In order to be aware about the ranks I earn
  As a user
  I want to receive notifications about new ranks

  Background:
    Given I am signed in as "volmer"
    And there is an universe called "Changeling: the Lost"
    And within "Changeling: the Lost" there is a rank with:
      | name      | description                  |
      | Enchanted | Just the tip of the iceberg. |

  Scenario: Get notified about a new rank
    Given I have earned the rank "Enchanted" in "Changeling: the Lost"
    When I go to the notifications page
    Then I see "Parabéns! Agora você é um Enchanted!" on the page
    And I receive an email titled "Parabéns! Agora você é um Enchanted!"
    And the email contains "volmer"
    And the email contains "Enchanted"
    And the email contains "Changeling: the Lost"
    And the email contains "Just the tip of the iceberg."
