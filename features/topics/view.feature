Feature: View topics
  In order to join discussions
  As an user
  I want to view the topics started

  Scenario: View a topic
    Given there is a topic called "Who is your favorite knight?" in the "Knights" forum
    When I go to the "Knights" forum
    And I click on "Who is your favorite knight?"
    Then I see "Who is your favorite knight?" on the page
    And I see the link "Deseja postar neste tópico? Entre aqui!"

  Scenario: List topics
    Given there is a topic called "Who is your favorite knight?" in the "Knights" forum
    Given there is a topic called "Did anyone already beat the Mountain?" in the "Knights" forum
    When I go to the "Knights" forum
    Then I see "Who is your favorite knight?" on the page
    And I see "Did anyone already beat the Mountain?" on the page

  Scenario: Paginate topics
    Given there are 25 topics on the "Knights" forum
    When I go to the "Knights" forum
    Then I see 3 pages
    And I see 10 topics
    And I see 5 topics in the page 3
