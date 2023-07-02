Feature: Abbandona Team

    Scenario: Abbandono team
    Given I am logged in as a user with uid 10548078
    And I am on the personstats page
    When I press "Abbandona"
    Then I should see "Team was successfully abandoned."  