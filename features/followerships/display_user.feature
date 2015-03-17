Feature: Display followerships
  In order to meet new users
  As a user
  I want to know who follows who

  Background:
    Given I am signed in as "volmer"
    And there is an user called "catelyn"
    And I am following catelyn

  Scenario: View followers
    When I go to catelyn's profile page
    And I click on "Seguidor"
    Then I see "volmer" on the page

  Scenario: View following
    When I go to my profile page
    And I click on "Seguindo"
    Then I see "catelyn" on the page

  Scenario: Paginate followerships
    Given there is an user called "bronn"
    And bronn follows 40 users
    When I go to bronn's profile page
    And I click on "Seguindo"
    Then I see 3 pages
    And I see 15 followed users
    And I see 10 followed users in the page 3

  Scenario: Paginate followers
    Given there is an user called "tyrion"
    And tyrion has 23 followers
    When I go to tyrion's profile page
    And I click on "Seguidores"
    Then I see 2 pages
    And I see 15 followers
    And I see 8 followers in the page 2

