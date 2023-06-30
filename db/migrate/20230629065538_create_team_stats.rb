class CreateTeamStats < ActiveRecord::Migration[6.1]
  def change
    create_table :team_stats do |t|
      t.references :team, null: false, foreign_key: true
      t.integer :uid
      t.integer :terranwins
      t.integer :protosswins
      t.integer :zergwins
      t.integer :careertotalgames
      t.integer :totalwins
      t.integer :totallosses
      t.float :wlratio
      t.integer :level
      t.integer :levelterran
      t.integer :totallevelxpterran
      t.integer :currentlevelxpterran
      t.integer :levelzerg
      t.integer :totallevelxpzerg
      t.integer :currentlevelxpzerg
      t.integer :levelprotoss
      t.integer :totallevelxpprotoss
      t.integer :currentlevelxpprotoss
      t.integer :wins1vs1
      t.integer :games1vs1
      t.integer :wins2vs2
      t.integer :games2vs2
      t.integer :wins3vs3
      t.integer :games3vs3
      t.integer :wins4vs4
      t.integer :games4vs4
      t.integer :winsarchon
      t.integer :gamesarchon
      t.integer :totalpointsachievements
      t.integer :seasontotalgames
      t.integer :totalgamesthisseason

      t.timestamps
    end
  end
end
