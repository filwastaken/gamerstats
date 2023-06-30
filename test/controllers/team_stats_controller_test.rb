require "test_helper"

class TeamStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team_stat = team_stats(:one)
  end

  test "should get index" do
    get team_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_team_stat_url
    assert_response :success
  end

  test "should create team_stat" do
    assert_difference('TeamStat.count') do
      post team_stats_url, params: { team_stat: { careertotalgames: @team_stat.careertotalgames, currentlevelxpprotoss: @team_stat.currentlevelxpprotoss, currentlevelxpterran: @team_stat.currentlevelxpterran, currentlevelxpzerg: @team_stat.currentlevelxpzerg, games1vs1: @team_stat.games1vs1, games2vs2: @team_stat.games2vs2, games3vs3: @team_stat.games3vs3, games4vs4: @team_stat.games4vs4, gamesarchon: @team_stat.gamesarchon, level: @team_stat.level, levelprotoss: @team_stat.levelprotoss, levelterran: @team_stat.levelterran, levelzerg: @team_stat.levelzerg, protosswins: @team_stat.protosswins, seasontotalgames: @team_stat.seasontotalgames, team_id: @team_stat.team_id, terranwins: @team_stat.terranwins, totalgamesthisseason: @team_stat.totalgamesthisseason, totallevelxpprotoss: @team_stat.totallevelxpprotoss, totallevelxpterran: @team_stat.totallevelxpterran, totallevelxpzerg: @team_stat.totallevelxpzerg, totallosses: @team_stat.totallosses, totalpointsachievements: @team_stat.totalpointsachievements, totalwins: @team_stat.totalwins, uid: @team_stat.uid, wins1vs1: @team_stat.wins1vs1, wins2vs2: @team_stat.wins2vs2, wins3vs3: @team_stat.wins3vs3, wins4vs4: @team_stat.wins4vs4, winsarchon: @team_stat.winsarchon, wlratio: @team_stat.wlratio, zergwins: @team_stat.zergwins } }
    end

    assert_redirected_to team_stat_url(TeamStat.last)
  end

  test "should show team_stat" do
    get team_stat_url(@team_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_stat_url(@team_stat)
    assert_response :success
  end

  test "should update team_stat" do
    patch team_stat_url(@team_stat), params: { team_stat: { careertotalgames: @team_stat.careertotalgames, currentlevelxpprotoss: @team_stat.currentlevelxpprotoss, currentlevelxpterran: @team_stat.currentlevelxpterran, currentlevelxpzerg: @team_stat.currentlevelxpzerg, games1vs1: @team_stat.games1vs1, games2vs2: @team_stat.games2vs2, games3vs3: @team_stat.games3vs3, games4vs4: @team_stat.games4vs4, gamesarchon: @team_stat.gamesarchon, level: @team_stat.level, levelprotoss: @team_stat.levelprotoss, levelterran: @team_stat.levelterran, levelzerg: @team_stat.levelzerg, protosswins: @team_stat.protosswins, seasontotalgames: @team_stat.seasontotalgames, team_id: @team_stat.team_id, terranwins: @team_stat.terranwins, totalgamesthisseason: @team_stat.totalgamesthisseason, totallevelxpprotoss: @team_stat.totallevelxpprotoss, totallevelxpterran: @team_stat.totallevelxpterran, totallevelxpzerg: @team_stat.totallevelxpzerg, totallosses: @team_stat.totallosses, totalpointsachievements: @team_stat.totalpointsachievements, totalwins: @team_stat.totalwins, uid: @team_stat.uid, wins1vs1: @team_stat.wins1vs1, wins2vs2: @team_stat.wins2vs2, wins3vs3: @team_stat.wins3vs3, wins4vs4: @team_stat.wins4vs4, winsarchon: @team_stat.winsarchon, wlratio: @team_stat.wlratio, zergwins: @team_stat.zergwins } }
    assert_redirected_to team_stat_url(@team_stat)
  end

  test "should destroy team_stat" do
    assert_difference('TeamStat.count', -1) do
      delete team_stat_url(@team_stat)
    end

    assert_redirected_to team_stats_url
  end
end
