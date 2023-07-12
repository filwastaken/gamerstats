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
  
  Scenario: Inserimento amministratore con password corta
    Given I am logged in as an Admin
    And I am on the new_admin page
    When I fill in "admin_email" with "guerra.1931976@studenti.uniroma1.it"
    And I fill in "admin_password" with "1"
    And I fill in "admin_password_confirmation" with "1"
    And I press "Aggiungi"
    Then I should see "La password deve contenere almeno 6 caratteri"
  
  Scenario: Inserimento amministratore con password diverse
    Given I am logged in as an Admin
    And I am on the new_admin page
    When I fill in "admin_email" with "guerra.1931976@studenti.uniroma1.it"
    And I fill in "admin_password" with "10000000"
    And I fill in "admin_password_confirmation" with "20000000"
    And I press "Aggiungi"
    Then I should see "Le password non corrispondono!"
  
  Scenario: Inserimento amministratore con password diverse
    Given I am logged in as an Admin
    And I am on the new_admin page
    When I fill in "admin_email" with "guerra.1931976@studenti.uniroma1.it"
    And I fill in "admin_password" with "10000000"
    And I fill in "admin_password_confirmation" with "20000000"
    And I press "Aggiungi"
    Then I should see "Le password non corrispondono!"

  Scenario: Inserimento duplicato di amministratore
    Given I am logged in as an Admin
    And a admin exists with admin_email: "guerra.1931976@studenti.uniroma1.it"
    And I am on the new_admin page
    When I fill in "admin_email" with "guerra.1931976@studenti.uniroma1.it"
    And I fill in "admin_password" with "0123456789"
    And I fill in "admin_password_confirmation" with "0123456789"
    And I press "Aggiungi"
    Then I should see "Esiste gia' un utente con questa email"
  
  Scenario: Inserimento corretto di amministratore
    Given I am logged in as an Admin
    And I am on the new_admin page
    When I fill in "admin_email" with "guerra.1931976@studenti.uniroma1.it"
    And I fill in "admin_password" with "0123456789"
    And I fill in "admin_password_confirmation" with "0123456789"
    And I press "Aggiungi"
    Then I should see "Admin was successfully created."