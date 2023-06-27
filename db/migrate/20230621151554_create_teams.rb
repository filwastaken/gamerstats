class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :nome_team
      t.string :giocatore1
      t.string :giocatore2
      t.string :giocatore3
      t.string :giocatore4

      t.timestamps
    end
  end
end
