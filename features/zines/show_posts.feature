Feature: View post
  In order to navigate through interesting contents
  As a user or a guest
  I want to find and view a post

  Background:
    Given there is a zine with the given attributes:
      | name                 | slug    |
      | A Dance With Dragons | dragons |

  Scenario: View a post directly
    Given within the zine "A Dance With Dragons" there is a post with the given attributes:
      | name     | content          | slug     |
      | Daenerys | She is betrayed. | daenerys |
    When I access the path "/zines/dragons/posts/daenerys"
    Then I see "A Dance With Dragons" on the page
    And I see "Daenerys" on the page
    And I see "She is betrayed." on the page
