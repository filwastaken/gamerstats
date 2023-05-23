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

ActiveRecord::Schema.define(version: 2023_05_20_205324) do

  create_table "stats", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "number"
    t.integer "preferredSlot"
    t.string "givenName"
    t.string "name"
    t.string "familyName"
    t.string "role"
    t.string "headshotUrl"
    t.string "eroe"
    t.integer "abilityDamageDone"
    t.integer "accretionKills"
    t.integer "amplificationMatrixAssists"
    t.integer "barrageKills"
    t.integer "bioticGrenadeKills"
    t.integer "blizzardKills"
    t.integer "bobKills"
    t.integer "carnageKills"
    t.integer "chainHooksAttempted"
    t.integer "chargedShotKills"
    t.integer "coalescenseHealing"
    t.integer "concussionMineKills"
    t.integer "criticalHits"
    t.integer "damageAmplified"
    t.integer "damageBlockedSojurn"
    t.integer "damageDiscordOrb"
    t.integer "damageTaken"
    t.integer "deadeyeKills"
    t.integer "deathBlossomKills"
    t.integer "deaths"
    t.integer "dragonbladeKills"
    t.integer "dragonstrikeKills"
    t.integer "earthshatterKills"
    t.integer "earthshatterStuns"
    t.integer "eliminations"
    t.integer "enemiesChainHooked"
    t.integer "enemiesEMPd"
    t.integer "enemiesFrozen"
    t.integer "enemiesHacked"
    t.integer "enemiesSlept"
    t.integer "energyMax"
    t.integer "finalBlows"
    t.integer "focusingBeamKills"
    t.integer "graviticFluxKills"
    t.integer "gravitonSurgeKills"
    t.integer "healingDone"
    t.integer "helixRocketKills"
    t.integer "heroDamageDone"
    t.integer "immortalityFieldDeathsPrevented"
    t.integer "inspireUptime"
    t.integer "jaggedBladeKills"
    t.integer "javelinDamage"
    t.integer "jumpPackKills"
    t.integer "kitsuneRushAssists"
    t.integer "knockbackKills"
    t.integer "kunaiKills"
    t.integer "lifetimeEnergyAccumulation"
    t.integer "meteorStrikeKills"
    t.integer "moltenCoreKills"
    t.integer "negativeEffectsCleansed"
    t.integer "overclockKills"
    t.integer "overhealthProvided"
    t.integer "piledriverKills"
    t.integer "playersKnockedBack"
    t.integer "playersResurrected"
    t.integer "playersTeleported"
    t.integer "primalRageKills"
    t.integer "pulseBombKills"
    t.integer "pulseBombsAttached"
    t.integer "ripTireKills"
    t.integer "rocketDirectHits"
    t.integer "scopedCriticalHitKills"
    t.integer "scopedCriticalHits"
    t.integer "scopedHits"
    t.integer "selfdestructKills"
    t.integer "shotsHit"
    t.integer "soloKills"
    t.integer "stickyBombsKills"
    t.integer "stormArrowKills"
    t.integer "tacticalVisorKills"
    t.integer "terraSurgeKills"
    t.integer "timePlayed"
    t.integer "timeSpentOnFire"
    t.integer "turretKills"
    t.integer "ultimatesNegated"
    t.integer "ultsEarned"
    t.integer "ultsUsed"
    t.integer "wholeHogKills"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.string "provider"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
