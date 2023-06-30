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
      post stats_url, params: { stat: { careerTotalGames: @stat.careerTotalGames, clanName: @stat.clanName, clanTag: @stat.clanTag, currentLevelXPProtoss: @stat.currentLevelXPProtoss, currentLevelXPTerran: @stat.currentLevelXPTerran, currentLevelXPZerg: @stat.currentLevelXPZerg, displayName: @stat.displayName, games1vs1: @stat.games1vs1, games2vs2: @stat.games2vs2, games3vs3: @stat.games3vs3, games4vs4: @stat.games4vs4, gamesArchon: @stat.gamesArchon, highest1v1Rank: @stat.highest1v1Rank, highestTeamRank: @stat.highestTeamRank, level: @stat.level, levelProtoss: @stat.levelProtoss, levelTerran: @stat.levelTerran, levelZerg: @stat.levelZerg, primaryRace: @stat.primaryRace, profilePath: @stat.profilePath, protossWins: @stat.protossWins, realm: @stat.realm, region: @stat.region, seasonId: @stat.seasonId, seasonNumber: @stat.seasonNumber, seasonTotalGames: @stat.seasonTotalGames, seasonYear: @stat.seasonYear, terranWins: @stat.terranWins, totalLevelXPProtoss: @stat.totalLevelXPProtoss, totalLevelXPTerran: @stat.totalLevelXPTerran, totalLevelXPZerg: @stat.totalLevelXPZerg, totalLosses: @stat.totalLosses, totalLossesThisSeason: @stat.totalLossesThisSeason, totalPointsAchievements: @stat.totalPointsAchievements, totalWins: @stat.totalWins, totalWinsThisSeason: @stat.totalWinsThisSeason, uid: @stat.uid, wins1vs1: @stat.wins1vs1, wins2vs2: @stat.wins2vs2, wins3vs3: @stat.wins3vs3, wins4vs4: @stat.wins4vs4, winsArchon: @stat.winsArchon, wlRatio: @stat.wlRatio, wlRatioThisSeason: @stat.wlRatioThisSeason, zergWins: @stat.zergWins } }
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
    patch stat_url(@stat), params: { stat: { careerTotalGames: @stat.careerTotalGames, clanName: @stat.clanName, clanTag: @stat.clanTag, currentLevelXPProtoss: @stat.currentLevelXPProtoss, currentLevelXPTerran: @stat.currentLevelXPTerran, currentLevelXPZerg: @stat.currentLevelXPZerg, displayName: @stat.displayName, games1vs1: @stat.games1vs1, games2vs2: @stat.games2vs2, games3vs3: @stat.games3vs3, games4vs4: @stat.games4vs4, gamesArchon: @stat.gamesArchon, highest1v1Rank: @stat.highest1v1Rank, highestTeamRank: @stat.highestTeamRank, level: @stat.level, levelProtoss: @stat.levelProtoss, levelTerran: @stat.levelTerran, levelZerg: @stat.levelZerg, primaryRace: @stat.primaryRace, profilePath: @stat.profilePath, protossWins: @stat.protossWins, realm: @stat.realm, region: @stat.region, seasonId: @stat.seasonId, seasonNumber: @stat.seasonNumber, seasonTotalGames: @stat.seasonTotalGames, seasonYear: @stat.seasonYear, terranWins: @stat.terranWins, totalLevelXPProtoss: @stat.totalLevelXPProtoss, totalLevelXPTerran: @stat.totalLevelXPTerran, totalLevelXPZerg: @stat.totalLevelXPZerg, totalLosses: @stat.totalLosses, totalLossesThisSeason: @stat.totalLossesThisSeason, totalPointsAchievements: @stat.totalPointsAchievements, totalWins: @stat.totalWins, totalWinsThisSeason: @stat.totalWinsThisSeason, uid: @stat.uid, wins1vs1: @stat.wins1vs1, wins2vs2: @stat.wins2vs2, wins3vs3: @stat.wins3vs3, wins4vs4: @stat.wins4vs4, winsArchon: @stat.winsArchon, wlRatio: @stat.wlRatio, wlRatioThisSeason: @stat.wlRatioThisSeason, zergWins: @stat.zergWins } }
    assert_redirected_to stat_url(@stat)
  end

  test "should destroy stat" do
    assert_difference('Stat.count', -1) do
      delete stat_url(@stat)
    end

    assert_redirected_to stats_url
  end
end
