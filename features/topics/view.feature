Feature: View topics
  In order to join discussions
  As an user
  I want to view the topics started

  Scenario: View a topic
    Given there is a topic called "Who is your favorite knight?" in "Knights"
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    Then I see "Who is your favorite knight?" on the page

  Scenario: List topics
    Given there is a topic called "Who is your favorite knight?" in "Knights"
    Given there is a topic called "Did anyone already beat the Mountain?" in "Knights"
    When I go to the "Knights" forum
    Then I see "Who is your favorite knight?" on the page
    And I see "Did anyone already beat the Mountain?" on the page
