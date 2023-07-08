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

    Scenario: Abbonamento disabilitato
      Given I am logged in as a user with uid 1962596
      And I am on the home page
      Then I can't press button "bottoneAbbonati"

    Scenario: TeamLeader
      Given I am logged in as a user with uid 151
      And I am on the home page
      When I press "Diventa Team Leader"
      Then I should see "Il ruolo è stato aggiornato con successo." 

    Scenario: TeamLeader disabilitato
      Given I am logged in as a user with uid 1962596
      And I am on the home page
      Then I can't press button "bottoneTeamLeader"