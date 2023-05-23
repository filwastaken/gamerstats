require "application_system_test_case"

class StatsTest < ApplicationSystemTestCase
  setup do
    @stat = stats(:one)
  end

  test "visiting the index" do
    visit stats_url
    assert_selector "h1", text: "Stats"
  end

  test "creating a Stat" do
    visit stats_url
    click_on "New Stat"

    fill_in "Abilitydamagedone", with: @stat.abilityDamageDone
    fill_in "Accretionkills", with: @stat.accretionKills
    fill_in "Amplificationmatrixassists", with: @stat.amplificationMatrixAssists
    fill_in "Barragekills", with: @stat.barrageKills
    fill_in "Bioticgrenadekills", with: @stat.bioticGrenadeKills
    fill_in "Blizzardkills", with: @stat.blizzardKills
    fill_in "Bobkills", with: @stat.bobKills
    fill_in "Carnagekills", with: @stat.carnageKills
    fill_in "Chainhooksattempted", with: @stat.chainHooksAttempted
    fill_in "Chargedshotkills", with: @stat.chargedShotKills
    fill_in "Coalescensehealing", with: @stat.coalescenseHealing
    fill_in "Concussionminekills", with: @stat.concussionMineKills
    fill_in "Criticalhits", with: @stat.criticalHits
    fill_in "Damageamplified", with: @stat.damageAmplified
    fill_in "Damageblockedsojurn", with: @stat.damageBlockedSojurn
    fill_in "Damagediscordorb", with: @stat.damageDiscordOrb
    fill_in "Damagetaken", with: @stat.damageTaken
    fill_in "Deadeyekills", with: @stat.deadeyeKills
    fill_in "Deathblossomkills", with: @stat.deathBlossomKills
    fill_in "Deaths", with: @stat.deaths
    fill_in "Dragonbladekills", with: @stat.dragonbladeKills
    fill_in "Dragonstrikekills", with: @stat.dragonstrikeKills
    fill_in "Earthshatterkills", with: @stat.earthshatterKills
    fill_in "Earthshatterstuns", with: @stat.earthshatterStuns
    fill_in "Eliminations", with: @stat.eliminations
    fill_in "Enemieschainhooked", with: @stat.enemiesChainHooked
    fill_in "Enemiesempd", with: @stat.enemiesEMPd
    fill_in "Enemiesfrozen", with: @stat.enemiesFrozen
    fill_in "Enemieshacked", with: @stat.enemiesHacked
    fill_in "Enemiesslept", with: @stat.enemiesSlept
    fill_in "Energymax", with: @stat.energyMax
    fill_in "Eroe", with: @stat.eroe
    fill_in "Familyname", with: @stat.familyName
    fill_in "Finalblows", with: @stat.finalBlows
    fill_in "Focusingbeamkills", with: @stat.focusingBeamKills
    fill_in "Givenname", with: @stat.givenName
    fill_in "Graviticfluxkills", with: @stat.graviticFluxKills
    fill_in "Gravitonsurgekills", with: @stat.gravitonSurgeKills
    fill_in "Headshoturl", with: @stat.headshotUrl
    fill_in "Healingdone", with: @stat.healingDone
    fill_in "Helixrocketkills", with: @stat.helixRocketKills
    fill_in "Herodamagedone", with: @stat.heroDamageDone
    fill_in "Id", with: @stat.id
    fill_in "Immortalityfielddeathsprevented", with: @stat.immortalityFieldDeathsPrevented
    fill_in "Inspireuptime", with: @stat.inspireUptime
    fill_in "Jaggedbladekills", with: @stat.jaggedBladeKills
    fill_in "Javelindamage", with: @stat.javelinDamage
    fill_in "Jumppackkills", with: @stat.jumpPackKills
    fill_in "Kitsunerushassists", with: @stat.kitsuneRushAssists
    fill_in "Knockbackkills", with: @stat.knockbackKills
    fill_in "Kunaikills", with: @stat.kunaiKills
    fill_in "Lifetimeenergyaccumulation", with: @stat.lifetimeEnergyAccumulation
    fill_in "Meteorstrikekills", with: @stat.meteorStrikeKills
    fill_in "Moltencorekills", with: @stat.moltenCoreKills
    fill_in "Name", with: @stat.name
    fill_in "Negativeeffectscleansed", with: @stat.negativeEffectsCleansed
    fill_in "Number", with: @stat.number
    fill_in "Overclockkills", with: @stat.overclockKills
    fill_in "Overhealthprovided", with: @stat.overhealthProvided
    fill_in "Piledriverkills", with: @stat.piledriverKills
    fill_in "Playersknockedback", with: @stat.playersKnockedBack
    fill_in "Playersresurrected", with: @stat.playersResurrected
    fill_in "Playersteleported", with: @stat.playersTeleported
    fill_in "Preferredslot", with: @stat.preferredSlot
    fill_in "Primalragekills", with: @stat.primalRageKills
    fill_in "Pulsebombkills", with: @stat.pulseBombKills
    fill_in "Pulsebombsattached", with: @stat.pulseBombsAttached
    fill_in "Riptirekills", with: @stat.ripTireKills
    fill_in "Rocketdirecthits", with: @stat.rocketDirectHits
    fill_in "Role", with: @stat.role
    fill_in "Scopedcriticalhitkills", with: @stat.scopedCriticalHitKills
    fill_in "Scopedcriticalhits", with: @stat.scopedCriticalHits
    fill_in "Scopedhits", with: @stat.scopedHits
    fill_in "Selfdestructkills", with: @stat.selfdestructKills
    fill_in "Shotshit", with: @stat.shotsHit
    fill_in "Solokills", with: @stat.soloKills
    fill_in "Stickybombskills", with: @stat.stickyBombsKills
    fill_in "Stormarrowkills", with: @stat.stormArrowKills
    fill_in "Tacticalvisorkills", with: @stat.tacticalVisorKills
    fill_in "Terrasurgekills", with: @stat.terraSurgeKills
    fill_in "Timeplayed", with: @stat.timePlayed
    fill_in "Timespentonfire", with: @stat.timeSpentOnFire
    fill_in "Turretkills", with: @stat.turretKills
    fill_in "Ultimatesnegated", with: @stat.ultimatesNegated
    fill_in "Ultsearned", with: @stat.ultsEarned
    fill_in "Ultsused", with: @stat.ultsUsed
    fill_in "Wholehogkills", with: @stat.wholeHogKills
    click_on "Create Stat"

    assert_text "Stat was successfully created"
    click_on "Back"
  end

  test "updating a Stat" do
    visit stats_url
    click_on "Edit", match: :first

    fill_in "Abilitydamagedone", with: @stat.abilityDamageDone
    fill_in "Accretionkills", with: @stat.accretionKills
    fill_in "Amplificationmatrixassists", with: @stat.amplificationMatrixAssists
    fill_in "Barragekills", with: @stat.barrageKills
    fill_in "Bioticgrenadekills", with: @stat.bioticGrenadeKills
    fill_in "Blizzardkills", with: @stat.blizzardKills
    fill_in "Bobkills", with: @stat.bobKills
    fill_in "Carnagekills", with: @stat.carnageKills
    fill_in "Chainhooksattempted", with: @stat.chainHooksAttempted
    fill_in "Chargedshotkills", with: @stat.chargedShotKills
    fill_in "Coalescensehealing", with: @stat.coalescenseHealing
    fill_in "Concussionminekills", with: @stat.concussionMineKills
    fill_in "Criticalhits", with: @stat.criticalHits
    fill_in "Damageamplified", with: @stat.damageAmplified
    fill_in "Damageblockedsojurn", with: @stat.damageBlockedSojurn
    fill_in "Damagediscordorb", with: @stat.damageDiscordOrb
    fill_in "Damagetaken", with: @stat.damageTaken
    fill_in "Deadeyekills", with: @stat.deadeyeKills
    fill_in "Deathblossomkills", with: @stat.deathBlossomKills
    fill_in "Deaths", with: @stat.deaths
    fill_in "Dragonbladekills", with: @stat.dragonbladeKills
    fill_in "Dragonstrikekills", with: @stat.dragonstrikeKills
    fill_in "Earthshatterkills", with: @stat.earthshatterKills
    fill_in "Earthshatterstuns", with: @stat.earthshatterStuns
    fill_in "Eliminations", with: @stat.eliminations
    fill_in "Enemieschainhooked", with: @stat.enemiesChainHooked
    fill_in "Enemiesempd", with: @stat.enemiesEMPd
    fill_in "Enemiesfrozen", with: @stat.enemiesFrozen
    fill_in "Enemieshacked", with: @stat.enemiesHacked
    fill_in "Enemiesslept", with: @stat.enemiesSlept
    fill_in "Energymax", with: @stat.energyMax
    fill_in "Eroe", with: @stat.eroe
    fill_in "Familyname", with: @stat.familyName
    fill_in "Finalblows", with: @stat.finalBlows
    fill_in "Focusingbeamkills", with: @stat.focusingBeamKills
    fill_in "Givenname", with: @stat.givenName
    fill_in "Graviticfluxkills", with: @stat.graviticFluxKills
    fill_in "Gravitonsurgekills", with: @stat.gravitonSurgeKills
    fill_in "Headshoturl", with: @stat.headshotUrl
    fill_in "Healingdone", with: @stat.healingDone
    fill_in "Helixrocketkills", with: @stat.helixRocketKills
    fill_in "Herodamagedone", with: @stat.heroDamageDone
    fill_in "Id", with: @stat.id
    fill_in "Immortalityfielddeathsprevented", with: @stat.immortalityFieldDeathsPrevented
    fill_in "Inspireuptime", with: @stat.inspireUptime
    fill_in "Jaggedbladekills", with: @stat.jaggedBladeKills
    fill_in "Javelindamage", with: @stat.javelinDamage
    fill_in "Jumppackkills", with: @stat.jumpPackKills
    fill_in "Kitsunerushassists", with: @stat.kitsuneRushAssists
    fill_in "Knockbackkills", with: @stat.knockbackKills
    fill_in "Kunaikills", with: @stat.kunaiKills
    fill_in "Lifetimeenergyaccumulation", with: @stat.lifetimeEnergyAccumulation
    fill_in "Meteorstrikekills", with: @stat.meteorStrikeKills
    fill_in "Moltencorekills", with: @stat.moltenCoreKills
    fill_in "Name", with: @stat.name
    fill_in "Negativeeffectscleansed", with: @stat.negativeEffectsCleansed
    fill_in "Number", with: @stat.number
    fill_in "Overclockkills", with: @stat.overclockKills
    fill_in "Overhealthprovided", with: @stat.overhealthProvided
    fill_in "Piledriverkills", with: @stat.piledriverKills
    fill_in "Playersknockedback", with: @stat.playersKnockedBack
    fill_in "Playersresurrected", with: @stat.playersResurrected
    fill_in "Playersteleported", with: @stat.playersTeleported
    fill_in "Preferredslot", with: @stat.preferredSlot
    fill_in "Primalragekills", with: @stat.primalRageKills
    fill_in "Pulsebombkills", with: @stat.pulseBombKills
    fill_in "Pulsebombsattached", with: @stat.pulseBombsAttached
    fill_in "Riptirekills", with: @stat.ripTireKills
    fill_in "Rocketdirecthits", with: @stat.rocketDirectHits
    fill_in "Role", with: @stat.role
    fill_in "Scopedcriticalhitkills", with: @stat.scopedCriticalHitKills
    fill_in "Scopedcriticalhits", with: @stat.scopedCriticalHits
    fill_in "Scopedhits", with: @stat.scopedHits
    fill_in "Selfdestructkills", with: @stat.selfdestructKills
    fill_in "Shotshit", with: @stat.shotsHit
    fill_in "Solokills", with: @stat.soloKills
    fill_in "Stickybombskills", with: @stat.stickyBombsKills
    fill_in "Stormarrowkills", with: @stat.stormArrowKills
    fill_in "Tacticalvisorkills", with: @stat.tacticalVisorKills
    fill_in "Terrasurgekills", with: @stat.terraSurgeKills
    fill_in "Timeplayed", with: @stat.timePlayed
    fill_in "Timespentonfire", with: @stat.timeSpentOnFire
    fill_in "Turretkills", with: @stat.turretKills
    fill_in "Ultimatesnegated", with: @stat.ultimatesNegated
    fill_in "Ultsearned", with: @stat.ultsEarned
    fill_in "Ultsused", with: @stat.ultsUsed
    fill_in "Wholehogkills", with: @stat.wholeHogKills
    click_on "Update Stat"

    assert_text "Stat was successfully updated"
    click_on "Back"
  end

  test "destroying a Stat" do
    visit stats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stat was successfully destroyed"
  end
end
