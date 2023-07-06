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

ActiveRecord::Schema.define(version: 2023_06_30_214324) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "nickname", default: ""
    t.boolean "bell", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true
  end

  create_table "maintenances", force: :cascade do |t|
    t.datetime "from", null: false
    t.datetime "to"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "from", null: false
    t.integer "to", null: false
    t.boolean "fromUser", default: false
    t.boolean "toUser", default: false
    t.string "body", null: false
    t.boolean "isinvitation", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "preferitos", force: :cascade do |t|
    t.string "mitt_id"
    t.string "nome_dest"
    t.string "dest_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stats", force: :cascade do |t|
    t.integer "uid"
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
    t.integer "totalWinsThisSeason"
    t.integer "totalLossesThisSeason"
    t.float "wlRatioThisSeason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_stats", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "uid"
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
    t.integer "uid", default: -1
    t.integer "battlenetId", default: -1
    t.string "nickname", default: ""
    t.integer "role", default: 0
    t.boolean "bell", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "team_stats", "teams"
end
