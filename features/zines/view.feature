Feature: View zine
  In order to navigate through interesting contents
  As a user or a guest
  I want to find and view a zine

  Scenario: List zines with posts
    Given there is a zine with the given attributes:
      | name                 | description |
      | A Dance With Dragons | Wildlings!  |
    And there is a zine with the given attributes:
      | name              | description |
      | A Game of Thrones | Why, Ned?   |
    And there is a zine with the given attributes:
      | name              | description |
      | Work in Progress  | WIP         |
    And within "A Dance With Dragons" there is a post called "Daenerys"
    And within "A Game of Thrones" there is a post called "Arya"
    When I go to the root page
    And I click on "Zines"
    Then I see "A Dance With Dragons" on the page
    And I see "A Game of Thrones" on the page
    And I see "Daenerys" on the page
    And I see "Arya" on the page
    And I don't see "Work in Progress" on the page
    And I see the link "Deseja criar um zine? Entre aqui!"

  Scenario: View a zine
    Given there is a zine with the given attributes:
      | name              | slug              | description |
      | A Game of Thrones | a-game-of-thrones | Why, Ned?   |
    When I access the path "/zines/a-game-of-thrones"
    Then I see "A Game of Thrones" on the page
    And I see "Why, Ned?" on the page

  @javascript
  Scenario: View my zines only
    Given I am signed in as "volmer"
    And I have a zine with the given attributes:
      | name                 | description |
      | A Dance With Dragons | Wildlings!  |
    And there is a zine with the given attributes:
      | name              | description |
      | A Game of Thrones | Why, Ned?   |
    When I go to the root page
    And I open my user menu
    And I click on "Meus zines"
    Then I see "Zines de volmer" on the page
    And I see "1 zine" on the page
    And I see "A Dance With Dragons" on the page
    And I don't see "A Game of Thrones" on the page

  Scenario: View zines in user page
    Given I am signed in
    And I have a zine with the given attributes:
      | name                 | description |
      | A Dance With Dragons | Wildlings!  |
    When I go to my profile page
    And I see "A Dance With Dragons" on the page

  Scenario: Paginate zines
    Given there are 22 zines with posts
    When I go to the root page
    And I click on "Zines"
    Then I see 3 pages
    And I see 10 zines
    And I see 2 zines in the page 3