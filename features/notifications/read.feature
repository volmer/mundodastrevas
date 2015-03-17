@javascript
Feature: Read Notifications
  In order to be aware of all relevant events
  As a user
  I want to be able to read the notifications triggered to me

  Background:
    Given I am signed in
    And I have 3 unread notifications
    And I am on the root page

  Scenario: Read the last notifications by the navbar menu
    When I open the notifications menu
    And I see 3 unread notifications
    And I go to the root page
    And I open the notifications menu
    Then I see 3 read notifications

  Scenario: Read the notifications in the notifications page
    When I go to the notifications page
    And I see 3 unread notifications
    And I go to the notifications page
    Then I see 3 read notifications

  Scenario: Paginate notifications
    Given I have 20 unread notifications
    When I go to the notifications page
    Then I see 3 pages
    And I see 10 unread notifications
    And I see 3 read notifications in the page 3
