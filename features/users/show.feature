Feature: Show user
  In order to check an user info
  As a signed in user
  I want to view the user profile page

  Background:
    Given there is an user signed up with the following data:
      | name     | email               | gender | bio                  | location   | birthday   |
      | catelyn  | catelyn@example.com | female | Duty, family, honor. | Winterfell | 1959-05-22 |

  Scenario: Show user to a signed in user
    Given I am signed in
    When I go to catelyn's profile page
    Then I see the page heading "catelyn"
    And I see "Duty, family, honor" on the page
