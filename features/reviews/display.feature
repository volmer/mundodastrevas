@javascript
Feature: Display reviews
  In order to know people's opinions
  As a user or a guest
  I want to view the ratings

  Scenario: View reviews
    Given there is a post called "Daenerys"
    And the post "Daenerys" has recieved 4 positive reviews
    And the post "Daenerys" has recieved 3 negative reviews
    When I go to the "Daenerys" post
    Then I see "4" in the "loved" post counter
    And I see "3" in the "hated" post counter
