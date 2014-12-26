Feature: Destroy comment
  In order to get rid of shameful words
  As a comment author
  I want to destroy my comment

  Background:
    Given I am signed in
    And I have a zine called "A Storm of Swords"
    And within "A Storm of Swords" there is a post called "Arya"
    And I've commented "The first zine was better." in the "Arya" post
    And I'm on the "Arya" post page

  Scenario: Successfully destroy post
    When within my comment I click on "Apagar"
    Then I see the info message "Comentário apagado."
    And I don't see "The first zine was better." on the page
