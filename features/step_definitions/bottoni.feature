Feature: Test Funzionamento Bottoni

    Scenario: Abbandono team
    Given I am logged in as a user with uid 10548078
    And I am on the personstats page
    When I press "Abbandona"
    Then I should see "Team was successfully abandoned."  

    Scenario: Abbonamento
    Given I am logged in as a user with uid 151
    And I am on the home page
    When I press "Abbonati"
    Then I should see "Il ruolo è stato aggiornato con successo." 

    Scenario: TeamLeader
    Given I am logged in as a user with uid 151
    And I am on the home page
    When I press "Diventa Team Leader"
    Then I should see "Il ruolo è stato aggiornato con successo." 