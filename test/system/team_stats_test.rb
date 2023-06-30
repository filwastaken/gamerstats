require "application_system_test_case"

class TeamStatsTest < ApplicationSystemTestCase
  setup do
    @team_stat = team_stats(:one)
  end

  test "visiting the index" do
    visit team_stats_url
    assert_selector "h1", text: "Team Stats"
  end

  test "creating a Team stat" do
    visit team_stats_url
    click_on "New Team Stat"

    fill_in "Careertotalgames", with: @team_stat.careertotalgames
    fill_in "Currentlevelxpprotoss", with: @team_stat.currentlevelxpprotoss
    fill_in "Currentlevelxpterran", with: @team_stat.currentlevelxpterran
    fill_in "Currentlevelxpzerg", with: @team_stat.currentlevelxpzerg
    fill_in "Games1vs1", with: @team_stat.games1vs1
    fill_in "Games2vs2", with: @team_stat.games2vs2
    fill_in "Games3vs3", with: @team_stat.games3vs3
    fill_in "Games4vs4", with: @team_stat.games4vs4
    fill_in "Gamesarchon", with: @team_stat.gamesarchon
    fill_in "Level", with: @team_stat.level
    fill_in "Levelprotoss", with: @team_stat.levelprotoss
    fill_in "Levelterran", with: @team_stat.levelterran
    fill_in "Levelzerg", with: @team_stat.levelzerg
    fill_in "Protosswins", with: @team_stat.protosswins
    fill_in "Seasontotalgames", with: @team_stat.seasontotalgames
    fill_in "Team", with: @team_stat.team_id
    fill_in "Terranwins", with: @team_stat.terranwins
    fill_in "Totalgamesthisseason", with: @team_stat.totalgamesthisseason
    fill_in "Totallevelxpprotoss", with: @team_stat.totallevelxpprotoss
    fill_in "Totallevelxpterran", with: @team_stat.totallevelxpterran
    fill_in "Totallevelxpzerg", with: @team_stat.totallevelxpzerg
    fill_in "Totallosses", with: @team_stat.totallosses
    fill_in "Totalpointsachievements", with: @team_stat.totalpointsachievements
    fill_in "Totalwins", with: @team_stat.totalwins
    fill_in "Uid", with: @team_stat.uid
    fill_in "Wins1vs1", with: @team_stat.wins1vs1
    fill_in "Wins2vs2", with: @team_stat.wins2vs2
    fill_in "Wins3vs3", with: @team_stat.wins3vs3
    fill_in "Wins4vs4", with: @team_stat.wins4vs4
    fill_in "Winsarchon", with: @team_stat.winsarchon
    fill_in "Wlratio", with: @team_stat.wlratio
    fill_in "Zergwins", with: @team_stat.zergwins
    click_on "Create Team stat"

    assert_text "Team stat was successfully created"
    click_on "Back"
  end

  test "updating a Team stat" do
    visit team_stats_url
    click_on "Edit", match: :first

    fill_in "Careertotalgames", with: @team_stat.careertotalgames
    fill_in "Currentlevelxpprotoss", with: @team_stat.currentlevelxpprotoss
    fill_in "Currentlevelxpterran", with: @team_stat.currentlevelxpterran
    fill_in "Currentlevelxpzerg", with: @team_stat.currentlevelxpzerg
    fill_in "Games1vs1", with: @team_stat.games1vs1
    fill_in "Games2vs2", with: @team_stat.games2vs2
    fill_in "Games3vs3", with: @team_stat.games3vs3
    fill_in "Games4vs4", with: @team_stat.games4vs4
    fill_in "Gamesarchon", with: @team_stat.gamesarchon
    fill_in "Level", with: @team_stat.level
    fill_in "Levelprotoss", with: @team_stat.levelprotoss
    fill_in "Levelterran", with: @team_stat.levelterran
    fill_in "Levelzerg", with: @team_stat.levelzerg
    fill_in "Protosswins", with: @team_stat.protosswins
    fill_in "Seasontotalgames", with: @team_stat.seasontotalgames
    fill_in "Team", with: @team_stat.team_id
    fill_in "Terranwins", with: @team_stat.terranwins
    fill_in "Totalgamesthisseason", with: @team_stat.totalgamesthisseason
    fill_in "Totallevelxpprotoss", with: @team_stat.totallevelxpprotoss
    fill_in "Totallevelxpterran", with: @team_stat.totallevelxpterran
    fill_in "Totallevelxpzerg", with: @team_stat.totallevelxpzerg
    fill_in "Totallosses", with: @team_stat.totallosses
    fill_in "Totalpointsachievements", with: @team_stat.totalpointsachievements
    fill_in "Totalwins", with: @team_stat.totalwins
    fill_in "Uid", with: @team_stat.uid
    fill_in "Wins1vs1", with: @team_stat.wins1vs1
    fill_in "Wins2vs2", with: @team_stat.wins2vs2
    fill_in "Wins3vs3", with: @team_stat.wins3vs3
    fill_in "Wins4vs4", with: @team_stat.wins4vs4
    fill_in "Winsarchon", with: @team_stat.winsarchon
    fill_in "Wlratio", with: @team_stat.wlratio
    fill_in "Zergwins", with: @team_stat.zergwins
    click_on "Update Team stat"

    assert_text "Team stat was successfully updated"
    click_on "Back"
  end

  test "destroying a Team stat" do
    visit team_stats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Team stat was successfully destroyed"
  end
end
