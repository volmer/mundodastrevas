Feature: View zine
  In order to navigate through interesting contents
  As a user or a guest
  I want to find and view a zine

  Scenario: List zines
    Given there is a zine with the given attributes:
      | name                 | description |
      | A Dance With Dragons | Wildlings!  |
    And there is a zine with the given attributes:
      | name              | description |
      | A Game of Thrones | Why, Ned?   |
    When I go to the root page
    And I click on "Zines"
    Then I see "A Dance With Dragons" on the page
    And I see "A Game of Thrones" on the page

  Scenario: View a zine
    Given there is a zine with the given attributes:
      | name              | slug              | description |
      | A Game of Thrones | a-game-of-thrones | Why, Ned?   |
    When I access the path "/zines/a-game-of-thrones"
    Then I see "A Game of Thrones" on the page
    And I see "Why, Ned?" on the page
