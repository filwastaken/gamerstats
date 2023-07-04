Feature: Inserimento di un nuovo Team

  Scenario: Inserimento di un nuovo Team valido
    Given I am logged in as a user with uid 10548078
    And I am on the new team page
    When I fill in "team_nome_team" with "myTeam"
    And I fill in "team_giocatore3" with "1"
    And I fill in "team_giocatore2" with "51"
    And I press "submit"
    Then I should see "Team was successfully created."

  Scenario: Inserimento di un nuovo Team con gli stessi giocatori di un altro team
    Given I am logged in as a user with uid 10548078
    And a team exists with giocatore1: "10548078", giocatore3: "1", giocatore2: "51"
    And I am on the new team page
    When I fill in "team_nome_team" with "myTeamE"
    And I fill in "team_giocatore3" with "1"
    And I fill in "team_giocatore2" with "51"
    And I press "submit"
    Then I should see "Esiste già un team con gli stessi giocatori!"

  Scenario: Inserimento di un nuovo Team con lo stesso nome di un altro team
    Given I am logged in as a user with uid 10548078
    And a team exists with team_nome_team: "myTeam"
    And I am on the new team page
    When I fill in "team_nome_team" with "myTeam"
    And I fill in "team_giocatore3" with "1"
    And I fill in "team_giocatore2" with "151"
    And I press "submit"
    Then I should see "Esiste già un team con lo stesso nome"

  Scenario: Inserimento di un nuovo Team con giocatori duplicati
    Given I am logged in as a user with uid 10548078
    And I am on the new team page
    When I fill in "team_nome_team" with "myTeamC"
    And I fill in "team_giocatore3" with "51"
    And I fill in "team_giocatore2" with "51"
    And I press "submit"
    Then I should see "Non puoi mettere due volte lo stesso id"

  Scenario: Inserimento di un nuovo Team con giocatori non esistenti nel gioco
    Given I am logged in as a user with uid 10548078
    And I am on the new team page
    When I fill in "team_nome_team" with "myTeamD"
    And I fill in "team_giocatore3" with "1"
    And I fill in "team_giocatore2" with "2"
    And I press "submit"
    Then I should see "Il giocatore con id 2 non ha un account nel gioco, inserire un altro id"

 