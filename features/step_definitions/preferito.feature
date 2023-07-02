Feature: Inserimento di un nuovo Team

  Scenario: Inserimento di un nuovo Preferito valido
    Given I am logged in as a user with uid 10548078
    And I am on the new preferito page
    When I fill in "preferito_nome_dest" with "Gino"
    And I fill in "preferito_dest_id" with "51"
    And I press "submit"
    Then I should see "Preferito was successfully created."

  Scenario: Inserimento di un nuovo Preferito già esistente
    Given I am logged in as a user with uid 10548078
    And a preferito exists with nome_dest: "Gino", dest_id: "1"
    And I am on the new preferito page
    When I fill in "preferito_nome_dest" with "Gino"
    And I fill in "preferito_dest_id" with "1"
    And I press "submit"
    Then I should see "Esiste già questo preferito!"

  Scenario: Inserimento di un nuovo Preferito non esistente nel gioco
    Given I am logged in as a user with uid 10548078
    And I am on the new preferito page
    When I fill in "preferito_nome_dest" with "Gino"
    And I fill in "preferito_dest_id" with "2"
    And I press "submit"
    Then I should see "Il giocatore con id 2 non ha un account nel gioco, inserire un altro id"

  Scenario: Inserimento di un nuovo Preferito uguale a current_user
    Given I am logged in as a user with uid 10548078
    And I am on the new preferito page
    When I fill in "preferito_nome_dest" with "Gino"
    And I fill in "preferito_dest_id" with "10548078"
    And I press "submit"
    Then I should see "Non puoi inserire te stesso tra i preferiti"