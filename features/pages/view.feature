Feature: View page
  In order to read important contents
  As a visitor or a registered user
  I want to access a page

  Scenario: Access the page directly
    Given there is a page with the following data:
      | slug         | title         | content           |
      | starks-words | Stark's Words | Winter is coming. |
    When I access the path "/pages/starks-words"
    Then I see "Stark's Words" on the page
    And I see "Winter is coming." on the page
