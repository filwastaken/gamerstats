# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_06_29_071548) do

  create_table "stats", primary_key: "uid", force: :cascade do |t|
    t.integer "region"
    t.integer "realm"
    t.string "displayName"
    t.integer "terranWins"
    t.integer "protossWins"
    t.integer "zergWins"
    t.integer "careerTotalGames"
    t.integer "totalWins"
    t.integer "totalLosses"
    t.float "wlRatio"
    t.integer "level"
    t.integer "levelTerran"
    t.integer "totalLevelXPTerran"
    t.integer "currentLevelXPTerran"
    t.integer "levelZerg"
    t.integer "totalLevelXPZerg"
    t.integer "currentLevelXPZerg"
    t.integer "levelProtoss"
    t.integer "totalLevelXPProtoss"
    t.integer "currentLevelXPProtoss"
    t.integer "wins1vs1"
    t.integer "games1vs1"
    t.integer "wins2vs2"
    t.integer "games2vs2"
    t.integer "wins3vs3"
    t.integer "games3vs3"
    t.integer "wins4vs4"
    t.integer "games4vs4"
    t.integer "winsArchon"
    t.integer "gamesArchon"
    t.integer "totalPointsAchievements"
    t.string "highest1v1Rank"
    t.string "highestTeamRank"
    t.string "clanName"
    t.string "clanTag"
    t.string "profilePath"
    t.string "primaryRace"
    t.integer "seasonId"
    t.integer "seasonNumber"
    t.integer "seasonYear"
    t.integer "seasonTotalGames"
    t.integer "totalGamesThisSeason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_stats", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "terranwins"
    t.integer "protosswins"
    t.integer "zergwins"
    t.integer "careertotalgames"
    t.integer "totalwins"
    t.integer "totallosses"
    t.float "wlratio"
    t.integer "level"
    t.integer "levelterran"
    t.integer "totallevelxpterran"
    t.integer "currentlevelxpterran"
    t.integer "levelzerg"
    t.integer "totallevelxpzerg"
    t.integer "currentlevelxpzerg"
    t.integer "levelprotoss"
    t.integer "totallevelxpprotoss"
    t.integer "currentlevelxpprotoss"
    t.integer "wins1vs1"
    t.integer "games1vs1"
    t.integer "wins2vs2"
    t.integer "games2vs2"
    t.integer "wins3vs3"
    t.integer "games3vs3"
    t.integer "wins4vs4"
    t.integer "games4vs4"
    t.integer "winsarchon"
    t.integer "gamesarchon"
    t.integer "totalpointsachievements"
    t.integer "seasontotalgames"
    t.integer "totalgamesthisseason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_team_stats_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "nome_team"
    t.string "giocatore1"
    t.string "giocatore2"
    t.string "giocatore3"
    t.string "giocatore4"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid"
    t.string "provider"
    t.string "full_name"
    t.string "avatar_url"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "team_stats", "teams"
end
