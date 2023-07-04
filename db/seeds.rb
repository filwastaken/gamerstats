# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#rails db:seed RAILS_ENV=test
=begin
User.create!(
    email: 'pinco.pallino@gmail.com',
    password: '111111',
    created_at: Time.now,
    updated_at: Time.now,
    battlenetId: 483181335,
    uid: 10548078,
    nickname: 'Ninjabippo',
    role: 3, 
    bell: FALSE
)

User.create!(
    email: '51@gmail.com',
    password: '111111',
    created_at: Time.now,
    updated_at: Time.now,
    battlenetId: 123456,
    uid: 51,
    nickname: 'SCARTA',
    role: 3, 
    bell: FALSE
)

User.create!(
    email: '1@gmail.com',
    password: '111111',
    created_at: Time.now,
    updated_at: Time.now,
    battlenetId: 123456,
    uid: 1,
    nickname: 'SCARTA',
    role: 3, 
    bell: FALSE
)

User.create!(
    email: '151@gmail.com',
    password: '111111',
    created_at: Time.now,
    updated_at: Time.now,
    battlenetId: 123456,
    uid: 151,
    nickname: 'Paoli',
    role: 0, 
    bell: FALSE
)

User.create!(
    email: '101@gmail.com',
    password: '111111',
    created_at: Time.now,
    updated_at: Time.now,
    battlenetId: 123456,
    uid: 101,
    nickname: 'Gino',
    role: 1, 
    bell: FALSE
)

User.create!(
    email: '1354@gmail.com',
    password: '111111',
    created_at: Time.now,
    updated_at: Time.now,
    battlenetId: 123456,
    uid: 1354,
    nickname: 'BELLO',
    role: 2, 
    bell: FALSE
)

Stat.create!(
    uid: 10548078,
    terranWins: 6,
    protossWins: 0,
    zergWins:0,
    careerTotalGames:5,
    totalWins:6,
    totalLosses:0,
    wlRatio:6,
    level:6,
    levelTerran:5,
    totalLevelXPTerran:125000,
    currentLevelXPTerran:10,
    levelZerg:97,
    totalLevelXPZerg:04,
    currentLevelXPZerg:1,
    levelProtoss:45000,
    totalLevelXPProtoss:1641,
    currentLevelXPProtoss:0,
    wins1vs1:5000,
    games1vs1:0,
    wins2vs2:0,
    games2vs2:0,
    wins3vs3:0,
    games3vs3:0,
    wins4vs4:0,
    games4vs4:0,
    winsArchon:0,
    gamesArchon:0,
    totalPointsAchievements:90,
    seasonTotalGames:5
)


TeamStat.create!(
      team_id:1,
      terranwins:0,
      protosswins:0,
      zergwins:0,
      careertotalgames:0,
      totalwins:0,
      totallosses:0,
      wlratio:0,
      level:0,
      levelterran:0,
      totallevelxpterran:0,
      currentlevelxpterran:0,
      levelzerg:0,
      totallevelxpzerg:0,
      currentlevelxpzerg:0,
      levelprotoss:0,
      totallevelxpprotoss:0,
      currentlevelxpprotoss:0,
      wins1vs1:0,
      games1vs1:0,
      wins2vs2:0,
      games2vs2:0,
      wins3vs3:0,
      games3vs3:0,
      wins4vs4:0,
      games4vs4:0,
      winsarchon:0,
      gamesarchon:0,
      totalpointsachievements:0,
      seasontotalgames:0,
      totalgamesthisseason: 0
)

Team.create!(
    nome_team: "nomeTeam",
    giocatore1: "1",
    giocatore2: "10548078",
    giocatore3: "",
    giocatore4: ""
)


Team.create!(
    nome_team: "myTeamB",
    giocatore1: "10548078",
    giocatore2: "51",
    giocatore3: "",
    giocatore4: ""
)


TeamStat.create!(
      team_id:2,
      terranwins:0,
      protosswins:0,
      zergwins:0,
      careertotalgames:0,
      totalwins:0,
      totallosses:0,
      wlratio:0,
      level:0,
      levelterran:0,
      totallevelxpterran:0,
      currentlevelxpterran:0,
      levelzerg:0,
      totallevelxpzerg:0,
      currentlevelxpzerg:0,
      levelprotoss:0,
      totallevelxpprotoss:0,
      currentlevelxpprotoss:0,
      wins1vs1:0,
      games1vs1:0,
      wins2vs2:0,
      games2vs2:0,
      wins3vs3:0,
      games3vs3:0,
      wins4vs4:0,
      games4vs4:0,
      winsarchon:0,
      gamesarchon:0,
      totalpointsachievements:0,
      seasontotalgames:0,
      totalgamesthisseason: 0
)

Stat.create!(
    uid: 151,
    terranWins: 6,
    protossWins: 0,
    zergWins:0,
    careerTotalGames:5,
    totalWins:1000,
    totalLosses:0,
    wlRatio:6,
    level:6,
    levelTerran:5,
    totalLevelXPTerran:125000,
    currentLevelXPTerran:10,
    levelZerg:97,
    totalLevelXPZerg:04,
    currentLevelXPZerg:1,
    levelProtoss:45000,
    totalLevelXPProtoss:1641,
    currentLevelXPProtoss:0,
    wins1vs1:5000,
    games1vs1:0,
    wins2vs2:0,
    games2vs2:0,
    wins3vs3:0,
    games3vs3:0,
    wins4vs4:0,
    games4vs4:0,
    winsArchon:0,
    gamesArchon:0,
    totalPointsAchievements:10000,
    seasonTotalGames:5
)
=end