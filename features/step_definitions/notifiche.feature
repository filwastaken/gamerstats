Feature: Invio comunicazione da parte di un amministratore

  Scenario: Invio corretto di una comunicazione da parte di un amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    When I fill in "notification_body" with "Ciao"
    And I select "pinco.pallino@gmail.com" in "notification_to"
    And I press "Invia comunicazione"
    Then I should see "La comunicazione è stata inviata correttamente"

    Scenario: Invio di una comunicazione senza testo da parte di un amministratore
    Given I am logged in as an Admin
    And I am on the admin page
    When I fill in "notification_body" with ""
    And I select "pinco.pallino@gmail.com" in "notification_to"
    And I press "Invia comunicazione"
    Then I should see "Non puoi inviare una comunicazione vuota!"