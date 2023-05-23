require "test_helper"

class StatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stat = stats(:one)
  end

  test "should get index" do
    get stats_url
    assert_response :success
  end

  test "should get new" do
    get new_stat_url
    assert_response :success
  end

  test "should create stat" do
    assert_difference('Stat.count') do
      post stats_url, params: { stat: { abilityDamageDone: @stat.abilityDamageDone, accretionKills: @stat.accretionKills, amplificationMatrixAssists: @stat.amplificationMatrixAssists, barrageKills: @stat.barrageKills, bioticGrenadeKills: @stat.bioticGrenadeKills, blizzardKills: @stat.blizzardKills, bobKills: @stat.bobKills, carnageKills: @stat.carnageKills, chainHooksAttempted: @stat.chainHooksAttempted, chargedShotKills: @stat.chargedShotKills, coalescenseHealing: @stat.coalescenseHealing, concussionMineKills: @stat.concussionMineKills, criticalHits: @stat.criticalHits, damageAmplified: @stat.damageAmplified, damageBlockedSojurn: @stat.damageBlockedSojurn, damageDiscordOrb: @stat.damageDiscordOrb, damageTaken: @stat.damageTaken, deadeyeKills: @stat.deadeyeKills, deathBlossomKills: @stat.deathBlossomKills, deaths: @stat.deaths, dragonbladeKills: @stat.dragonbladeKills, dragonstrikeKills: @stat.dragonstrikeKills, earthshatterKills: @stat.earthshatterKills, earthshatterStuns: @stat.earthshatterStuns, eliminations: @stat.eliminations, enemiesChainHooked: @stat.enemiesChainHooked, enemiesEMPd: @stat.enemiesEMPd, enemiesFrozen: @stat.enemiesFrozen, enemiesHacked: @stat.enemiesHacked, enemiesSlept: @stat.enemiesSlept, energyMax: @stat.energyMax, eroe: @stat.eroe, familyName: @stat.familyName, finalBlows: @stat.finalBlows, focusingBeamKills: @stat.focusingBeamKills, givenName: @stat.givenName, graviticFluxKills: @stat.graviticFluxKills, gravitonSurgeKills: @stat.gravitonSurgeKills, headshotUrl: @stat.headshotUrl, healingDone: @stat.healingDone, helixRocketKills: @stat.helixRocketKills, heroDamageDone: @stat.heroDamageDone, id: @stat.id, immortalityFieldDeathsPrevented: @stat.immortalityFieldDeathsPrevented, inspireUptime: @stat.inspireUptime, jaggedBladeKills: @stat.jaggedBladeKills, javelinDamage: @stat.javelinDamage, jumpPackKills: @stat.jumpPackKills, kitsuneRushAssists: @stat.kitsuneRushAssists, knockbackKills: @stat.knockbackKills, kunaiKills: @stat.kunaiKills, lifetimeEnergyAccumulation: @stat.lifetimeEnergyAccumulation, meteorStrikeKills: @stat.meteorStrikeKills, moltenCoreKills: @stat.moltenCoreKills, name: @stat.name, negativeEffectsCleansed: @stat.negativeEffectsCleansed, number: @stat.number, overclockKills: @stat.overclockKills, overhealthProvided: @stat.overhealthProvided, piledriverKills: @stat.piledriverKills, playersKnockedBack: @stat.playersKnockedBack, playersResurrected: @stat.playersResurrected, playersTeleported: @stat.playersTeleported, preferredSlot: @stat.preferredSlot, primalRageKills: @stat.primalRageKills, pulseBombKills: @stat.pulseBombKills, pulseBombsAttached: @stat.pulseBombsAttached, ripTireKills: @stat.ripTireKills, rocketDirectHits: @stat.rocketDirectHits, role: @stat.role, scopedCriticalHitKills: @stat.scopedCriticalHitKills, scopedCriticalHits: @stat.scopedCriticalHits, scopedHits: @stat.scopedHits, selfdestructKills: @stat.selfdestructKills, shotsHit: @stat.shotsHit, soloKills: @stat.soloKills, stickyBombsKills: @stat.stickyBombsKills, stormArrowKills: @stat.stormArrowKills, tacticalVisorKills: @stat.tacticalVisorKills, terraSurgeKills: @stat.terraSurgeKills, timePlayed: @stat.timePlayed, timeSpentOnFire: @stat.timeSpentOnFire, turretKills: @stat.turretKills, ultimatesNegated: @stat.ultimatesNegated, ultsEarned: @stat.ultsEarned, ultsUsed: @stat.ultsUsed, wholeHogKills: @stat.wholeHogKills } }
    end

    assert_redirected_to stat_url(Stat.last)
  end

  test "should show stat" do
    get stat_url(@stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_stat_url(@stat)
    assert_response :success
  end

  test "should update stat" do
    patch stat_url(@stat), params: { stat: { abilityDamageDone: @stat.abilityDamageDone, accretionKills: @stat.accretionKills, amplificationMatrixAssists: @stat.amplificationMatrixAssists, barrageKills: @stat.barrageKills, bioticGrenadeKills: @stat.bioticGrenadeKills, blizzardKills: @stat.blizzardKills, bobKills: @stat.bobKills, carnageKills: @stat.carnageKills, chainHooksAttempted: @stat.chainHooksAttempted, chargedShotKills: @stat.chargedShotKills, coalescenseHealing: @stat.coalescenseHealing, concussionMineKills: @stat.concussionMineKills, criticalHits: @stat.criticalHits, damageAmplified: @stat.damageAmplified, damageBlockedSojurn: @stat.damageBlockedSojurn, damageDiscordOrb: @stat.damageDiscordOrb, damageTaken: @stat.damageTaken, deadeyeKills: @stat.deadeyeKills, deathBlossomKills: @stat.deathBlossomKills, deaths: @stat.deaths, dragonbladeKills: @stat.dragonbladeKills, dragonstrikeKills: @stat.dragonstrikeKills, earthshatterKills: @stat.earthshatterKills, earthshatterStuns: @stat.earthshatterStuns, eliminations: @stat.eliminations, enemiesChainHooked: @stat.enemiesChainHooked, enemiesEMPd: @stat.enemiesEMPd, enemiesFrozen: @stat.enemiesFrozen, enemiesHacked: @stat.enemiesHacked, enemiesSlept: @stat.enemiesSlept, energyMax: @stat.energyMax, eroe: @stat.eroe, familyName: @stat.familyName, finalBlows: @stat.finalBlows, focusingBeamKills: @stat.focusingBeamKills, givenName: @stat.givenName, graviticFluxKills: @stat.graviticFluxKills, gravitonSurgeKills: @stat.gravitonSurgeKills, headshotUrl: @stat.headshotUrl, healingDone: @stat.healingDone, helixRocketKills: @stat.helixRocketKills, heroDamageDone: @stat.heroDamageDone, id: @stat.id, immortalityFieldDeathsPrevented: @stat.immortalityFieldDeathsPrevented, inspireUptime: @stat.inspireUptime, jaggedBladeKills: @stat.jaggedBladeKills, javelinDamage: @stat.javelinDamage, jumpPackKills: @stat.jumpPackKills, kitsuneRushAssists: @stat.kitsuneRushAssists, knockbackKills: @stat.knockbackKills, kunaiKills: @stat.kunaiKills, lifetimeEnergyAccumulation: @stat.lifetimeEnergyAccumulation, meteorStrikeKills: @stat.meteorStrikeKills, moltenCoreKills: @stat.moltenCoreKills, name: @stat.name, negativeEffectsCleansed: @stat.negativeEffectsCleansed, number: @stat.number, overclockKills: @stat.overclockKills, overhealthProvided: @stat.overhealthProvided, piledriverKills: @stat.piledriverKills, playersKnockedBack: @stat.playersKnockedBack, playersResurrected: @stat.playersResurrected, playersTeleported: @stat.playersTeleported, preferredSlot: @stat.preferredSlot, primalRageKills: @stat.primalRageKills, pulseBombKills: @stat.pulseBombKills, pulseBombsAttached: @stat.pulseBombsAttached, ripTireKills: @stat.ripTireKills, rocketDirectHits: @stat.rocketDirectHits, role: @stat.role, scopedCriticalHitKills: @stat.scopedCriticalHitKills, scopedCriticalHits: @stat.scopedCriticalHits, scopedHits: @stat.scopedHits, selfdestructKills: @stat.selfdestructKills, shotsHit: @stat.shotsHit, soloKills: @stat.soloKills, stickyBombsKills: @stat.stickyBombsKills, stormArrowKills: @stat.stormArrowKills, tacticalVisorKills: @stat.tacticalVisorKills, terraSurgeKills: @stat.terraSurgeKills, timePlayed: @stat.timePlayed, timeSpentOnFire: @stat.timeSpentOnFire, turretKills: @stat.turretKills, ultimatesNegated: @stat.ultimatesNegated, ultsEarned: @stat.ultsEarned, ultsUsed: @stat.ultsUsed, wholeHogKills: @stat.wholeHogKills } }
    assert_redirected_to stat_url(@stat)
  end

  test "should destroy stat" do
    assert_difference('Stat.count', -1) do
      delete stat_url(@stat)
    end

    assert_redirected_to stats_url
  end
end
