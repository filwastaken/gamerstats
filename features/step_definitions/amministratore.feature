Feature: Controlli di eliminazione team, eliminazione utente, regalo abbonamento e manutenzione da parte dell'amministratore
  Scenario: Eliminazione di un team da parte dell'amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    And I click the button with id "delete2team"
    Then I should see "Team eliminato con successo."
  
  Scenario: Eliminazione di un utente da parte di un amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    And I click the button with id "delete4user"
    Then I should see "Utente eliminato con successo."
  
  Scenario: Regalo abbonamento da parte di un amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    And I click the button with id "gift4user"
    Then I should see "Regalo inviato con successo!"
  
  Scenario: Inizio manutenzione da parte di un amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    And I press "Inizia la manutenzione"
    Then I should see "Manutenzione iniziata con successo."
  
  Scenario: Inizio manutenzione da parte di un amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    And I press "Inizia la manutenzione"
    And I press "Interrompi la manutenzione"
    Then I should see "Manutenzione interrotta con successo."