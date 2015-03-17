Feature: View tags
  In order to find related content
  As an user
  I want to view tags and tagged content

  Scenario: View tag
    Given there is a post named "Daenerys" tagged as "fantasy"
    When I go to the "Daenerys" post
    And I click on "fantasy"
    Then I see "Tag: fantasy" on the page
    And I see "Daenerys" on the page

  Scenario: Paginate tag results
    Given there are 23 posts tagged as "fantasy"
    When I access the path "/tags/fantasy"
    Then I see 3 pages
    And I see 10 tag results
    And I see 3 tag results in the page 3
