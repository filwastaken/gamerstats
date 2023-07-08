# TODO

Feature: Eliminazione utenti e team da parte di un amministratore
  Scenario: Eliminazione di un team da parte dell'amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    And I press "Delete team"
    Then I should see "Team eliminato con successo."
  
  Scenario: Eliminazione di un utente da parte di un amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    And I press "Delete user"
    Then I should see ""
  
  Scenario: Regalo abbonamento da parte di un amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    And I press "Gift subscription"
    Then I should see "Non puoi inviare una comunicazione vuota!"