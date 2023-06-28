class CreateStats < ActiveRecord::Migration[6.1]
  def change
    create_table :stats, id: false do |t|
      t.integer :uid, primary_key: true
      t.integer :region
      t.integer :realm
      t.string :displayName
      t.string :clanName
      t.string :clanTag
      t.string :profilePath
      t.string :primaryRace
      t.integer :terranWins
      t.integer :protossWins
      t.integer :zergWins
      t.string :highest1v1Rank
      t.string :highestTeamRank
      t.integer :seasonTotalGames
      t.integer :careerTotalGames
      t.integer :level
      t.integer :levelTerran
      t.integer :totalLevelXPTerran
      t.integer :currentLevelXPTerran
      t.integer :levelZerg
      t.integer :totalLevelXPZerg
      t.integer :currentLevelXPZerg
      t.integer :levelProtoss
      t.integer :totalLevelXPProtoss
      t.integer :currentLevelXPProtoss
      t.integer :seasonId
      t.integer :seasonNumber
      t.integer :seasonYear
      t.integer :totalGamesThisSeason
      t.integer :wins1vs1
      t.integer :games1vs1
      t.integer :wins2vs2
      t.integer :games2vs2
      t.integer :wins3vs3
      t.integer :games3vs3
      t.integer :wins4vs4
      t.integer :games4vs4
      t.integer :winsArchon
      t.integer :gamesArchon
      t.integer :totalPointsAchievements

      t.timestamps
    end
  end
end
