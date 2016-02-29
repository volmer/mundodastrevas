@javascript
Feature: Read Notifications
  In order to be aware of all relevant events
  As a user
  I want to be able to read the notifications triggered to me

  Background:
    Given I am signed in
    And I have 3 unread notifications
    And I am on the root page

  Scenario: Read notifications
    When I click on "Notificações"
    And I see 3 unread notifications
    And I click on the first notification
    And I go to the notifications page
    Then I see 1 read notification
    And I see 2 unread notifications

  Scenario: Paginate notifications
    Given I have 20 unread notifications
    When I click on "Notificações"
    Then I see 3 pages
    And I see 10 unread notifications
    And I see 3 unread notifications in the page 3
