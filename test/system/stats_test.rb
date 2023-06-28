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

    fill_in "Careertotalgames", with: @stat.careerTotalGames
    fill_in "Clanname", with: @stat.clanName
    fill_in "Clantag", with: @stat.clanTag
    fill_in "Currentlevelxpprotoss", with: @stat.currentLevelXPProtoss
    fill_in "Currentlevelxpterran", with: @stat.currentLevelXPTerran
    fill_in "Currentlevelxpzerg", with: @stat.currentLevelXPZerg
    fill_in "Displayname", with: @stat.displayName
    fill_in "Games1vs1", with: @stat.games1vs1
    fill_in "Games2vs2", with: @stat.games2vs2
    fill_in "Games3vs3", with: @stat.games3vs3
    fill_in "Games4vs4", with: @stat.games4vs4
    fill_in "Gamesarchon", with: @stat.gamesArchon
    fill_in "Highest1v1rank", with: @stat.highest1v1Rank
    fill_in "Highestteamrank", with: @stat.highestTeamRank
    fill_in "Level", with: @stat.level
    fill_in "Levelprotoss", with: @stat.levelProtoss
    fill_in "Levelterran", with: @stat.levelTerran
    fill_in "Levelzerg", with: @stat.levelZerg
    fill_in "Primaryrace", with: @stat.primaryRace
    fill_in "Profilepath", with: @stat.profilePath
    fill_in "Protosswins", with: @stat.protossWins
    fill_in "Realm", with: @stat.realm
    fill_in "Region", with: @stat.region
    fill_in "Seasonid", with: @stat.seasonId
    fill_in "Seasonnumber", with: @stat.seasonNumber
    fill_in "Seasontotalgames", with: @stat.seasonTotalGames
    fill_in "Seasonyear", with: @stat.seasonYear
    fill_in "Terranwins", with: @stat.terranWins
    fill_in "Totalgamesthisseason", with: @stat.totalGamesThisSeason
    fill_in "Totallevelxpprotoss", with: @stat.totalLevelXPProtoss
    fill_in "Totallevelxpterran", with: @stat.totalLevelXPTerran
    fill_in "Totallevelxpzerg", with: @stat.totalLevelXPZerg
    fill_in "Totallosses", with: @stat.totalLosses
    fill_in "Totalpointsachievements", with: @stat.totalPointsAchievements
    fill_in "Totalwins", with: @stat.totalWins
    fill_in "Uid", with: @stat.uid
    fill_in "Wins1vs1", with: @stat.wins1vs1
    fill_in "Wins2vs2", with: @stat.wins2vs2
    fill_in "Wins3vs3", with: @stat.wins3vs3
    fill_in "Wins4vs4", with: @stat.wins4vs4
    fill_in "Winsarchon", with: @stat.winsArchon
    fill_in "Wlratio", with: @stat.wlRatio
    fill_in "Zergwins", with: @stat.zergWins
    click_on "Create Stat"

    assert_text "Stat was successfully created"
    click_on "Back"
  end

  test "updating a Stat" do
    visit stats_url
    click_on "Edit", match: :first

    fill_in "Careertotalgames", with: @stat.careerTotalGames
    fill_in "Clanname", with: @stat.clanName
    fill_in "Clantag", with: @stat.clanTag
    fill_in "Currentlevelxpprotoss", with: @stat.currentLevelXPProtoss
    fill_in "Currentlevelxpterran", with: @stat.currentLevelXPTerran
    fill_in "Currentlevelxpzerg", with: @stat.currentLevelXPZerg
    fill_in "Displayname", with: @stat.displayName
    fill_in "Games1vs1", with: @stat.games1vs1
    fill_in "Games2vs2", with: @stat.games2vs2
    fill_in "Games3vs3", with: @stat.games3vs3
    fill_in "Games4vs4", with: @stat.games4vs4
    fill_in "Gamesarchon", with: @stat.gamesArchon
    fill_in "Highest1v1rank", with: @stat.highest1v1Rank
    fill_in "Highestteamrank", with: @stat.highestTeamRank
    fill_in "Level", with: @stat.level
    fill_in "Levelprotoss", with: @stat.levelProtoss
    fill_in "Levelterran", with: @stat.levelTerran
    fill_in "Levelzerg", with: @stat.levelZerg
    fill_in "Primaryrace", with: @stat.primaryRace
    fill_in "Profilepath", with: @stat.profilePath
    fill_in "Protosswins", with: @stat.protossWins
    fill_in "Realm", with: @stat.realm
    fill_in "Region", with: @stat.region
    fill_in "Seasonid", with: @stat.seasonId
    fill_in "Seasonnumber", with: @stat.seasonNumber
    fill_in "Seasontotalgames", with: @stat.seasonTotalGames
    fill_in "Seasonyear", with: @stat.seasonYear
    fill_in "Terranwins", with: @stat.terranWins
    fill_in "Totalgamesthisseason", with: @stat.totalGamesThisSeason
    fill_in "Totallevelxpprotoss", with: @stat.totalLevelXPProtoss
    fill_in "Totallevelxpterran", with: @stat.totalLevelXPTerran
    fill_in "Totallevelxpzerg", with: @stat.totalLevelXPZerg
    fill_in "Totallosses", with: @stat.totalLosses
    fill_in "Totalpointsachievements", with: @stat.totalPointsAchievements
    fill_in "Totalwins", with: @stat.totalWins
    fill_in "Uid", with: @stat.uid
    fill_in "Wins1vs1", with: @stat.wins1vs1
    fill_in "Wins2vs2", with: @stat.wins2vs2
    fill_in "Wins3vs3", with: @stat.wins3vs3
    fill_in "Wins4vs4", with: @stat.wins4vs4
    fill_in "Winsarchon", with: @stat.winsArchon
    fill_in "Wlratio", with: @stat.wlRatio
    fill_in "Zergwins", with: @stat.zergWins
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
