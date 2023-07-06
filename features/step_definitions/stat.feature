Feature: Visualizzazione statistiche

  Scenario: Visualizzazione statistiche di un utente classico
    Given I am logged in as a user with uid 151
    And I am on the personstats page
    Then Non dovrebbe essere presente l'elemento con id "abbonatoStats"

  Scenario: Visualizzazione statistiche di un utente abbonato
    Given I am logged in as a user with uid 10548078
    And I am on the personstats page
    Then Dovrebbe essere presente l'elemento con id "abbonatoStats"

  Scenario: Visualizzazione statistiche di un utente teamLeader
    Given I am logged in as a user with uid 101
    And I am on the personstats page
    Then Non dovrebbe essere presente l'elemento con id "teamAbbonatoStats"

  Scenario: Visualizzazione statistiche di un utente teamLeaderAbbonato
    Given I am logged in as a user with uid 10548078
    And I am on the personstats page
    Then Dovrebbe essere presente l'elemento con id "teamAbbonatoStats"