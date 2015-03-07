Feature: View forum
  In order to navigate through topics and posts
  As a user or a guest
  I want to find and view a forum

  Scenario: List forums
    Given there is a forum with the given attributes:
      | name          | description                         |
      | The Gathering | Reunion of the High Wizards of Myr. |
    And there is a forum with the given attributes:
      | name                     | description     |
      | Brothers Without Banners | For the people! |
    When I go to the root page
    And I click on "Fóruns"
    Then I see "The Gathering" on the page
    And I see "Reunion of the High Wizards of Myr." on the page
    And I see "Brothers Without Banners" on the page
    And I see "For the people!" on the page

  Scenario: View a forum
    Given there is a forum with the given attributes:
      | name                     | slug                     | description     |
      | Brothers Without Banners | brothers-without-banners | For the people! |
    When I access the path "/forums/brothers-without-banners"
    Then I see "Brothers Without Banners" on the page
    And I see "For the people!" on the page
    And I see the link "Deseja participar deste fórum? Entre aqui!"
