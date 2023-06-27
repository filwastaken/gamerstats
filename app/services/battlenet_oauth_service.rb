class BattlenetOauthService
    require 'net/http'
    require 'openssl'
    require 'uri'

    colonne = ["id", "realm", "displayName", "clanName", "clanTag", "profilePath", "primaryRace", "terranWins","protossWins","zergWins","highest1v1Rank","highestTeamRank","seasonTotalGames","careerTotalGames","level","levelTerran","totalLevelXPTerran","currentLevelXPTerran","levelZerg","totalLevelXPZerg","currentLevelXPZerg","levelProtoss","totalLevelXPProtoss","currentLevelXPProtoss","seasonId","seasonNumber","seasonYear","totalGamesThisSeason","wins1vs1","games1vs1","wins2vs2","games2vs2","wins3vs3","games3vs3","wins4vs4","games4vs4","winsArchon","gamesArchon","totalPointsAchievements"]

    def self.ottieniInfoProfilo(access_token, regionId, realmId, profileId)
        if access_token == nil
            return nil
        end
        #puts "#{regionId} #{realmId} #{profileId}"

        url = URI.parse("https://us.api.blizzard.com/sc2/legacy/profile/#{regionId}/#{realmId}/#{profileId}")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == "https")

        request = Net::HTTP::Get.new(url.path)
        request["Authorization"] = "Bearer #{access_token}"
        response = http.request(request)

        return [] if response.code == "404"

        begin
            #puts "INIZIO--------------"
            body = JSON.parse(response.body)

            if Stat.exists?(id: profileId)
                userFromDB = Stat.find_by(id: profileId)

                if(body["season"]["seasonId"] == userFromDB.seasonId and body["season"]["seasonNumber"] == userFromDB.seasonNumber and body["season"]["seasonYear"] == userFromDB.seasonYear)

                    if(body["career"]["primaryRace"] != nil) 
                        userFromDB.realm = body["realm"]
                    end

                    if(body["displayName"] != "")
                        userFromDB.displayName = body["displayName"]
                    end

                    if(body["clanName"] != "")
                        userFromDB.clanName = body["clanName"]
                    end

                    if(body["clanTag"] != "")
                        userFromDB.clanTag = body["clanTag"]
                    end
                    if(body["profilePath"] != "")
                        userFromDB.profilePath = body["profilePath"]
                    end

                    if(body["career"]["primaryRace"] != nil)
                        userFromDB.primaryRace = body["career"]["primaryRace"]
                    end
                    
                    if(body["career"]["terranWins"] != nil)
                        userFromDB.terranWins = body["career"]["terranWins"]
                    end
                    
                    if(body["career"]["protossWins"] != nil)
                        userFromDB.protossWins = body["career"]["protossWins"]
                    end
                    
                    if(body["career"]["zergWins"] != nil)
                        userFromDB.zergWins = body["career"]["zergWins"]
                    end
                    
                    if(body["career"]["highest1v1Rank"] != nil) 
                        userFromDB.highest1v1Rank = body["career"]["highest1v1Rank"]
                    end

                    if(body["career"]["highestTeamRank"] != nil)
                        userFromDB.highestTeamRank = body["career"]["highestTeamRank"]
                    end
                    
                    if(body["career"]["seasonTotalGames"] != nil)
                        userFromDB.seasonTotalGames = body["career"]["seasonTotalGames"]
                    end
                    
                    if(body["career"]["careerTotalGames"] != nil)
                        userFromDB.careerTotalGames = body["career"]["careerTotalGames"]
                    end

                    if(body["swarmLevels"]["level"] != nil)
                        userFromDB.level = body["swarmLevels"]["level"]
                    end

                    if(body["swarmLevels"]["terran"]["level"] != nil)
                        userFromDB.levelTerran = body["swarmLevels"]["terran"]["level"]
                    end
                    
                    if(body["swarmLevels"]["terran"]["totalLevelXP"] != nil)
                        userFromDB.totalLevelXPTerran = body["swarmLevels"]["terran"]["totalLevelXP"]
                    end

                    if(body["swarmLevels"]["terran"]["currentLevelXP"] != nil)
                        userFromDB.currentLevelXPTerran = body["swarmLevels"]["terran"]["currentLevelXP"]
                    end

                    if(body["swarmLevels"]["zerg"]["level"] != nil)
                        userFromDB.levelZerg = body["swarmLevels"]["zerg"]["level"]
                    end

                    if(body["swarmLevels"]["zerg"]["totalLevelXP"] != nil)
                        userFromDB.totalLevelXPZerg = body["swarmLevels"]["zerg"]["totalLevelXP"]
                    end

                    if(body["swarmLevels"]["zerg"]["currentLevelXP"] != nil)
                        userFromDB.currentLevelXPZerg = body["swarmLevels"]["zerg"]["currentLevelXP"]
                    end

                    if(body["swarmLevels"]["protoss"]["level"] != nil)
                        userFromDB.levelProtoss = body["swarmLevels"]["protoss"]["level"]
                    end

                    if(body["swarmLevels"]["protoss"]["totalLevelXP"] != nil)
                        userFromDB.totalLevelXPProtoss = body["swarmLevels"]["protoss"]["totalLevelXP"]
                    end

                    if(body["swarmLevels"]["protoss"]["currentLevelXP"] != nil)
                        userFromDB.currentLevelXPProtoss = body["swarmLevels"]["protoss"]["currentLevelXP"]
                    end

                    if(body["season"]["seasonId"] != nil)
                        userFromDB.seasonId = body["season"]["seasonId"]
                    end
                    
                    if(body["season"]["seasonNumber"] != nil) 
                        userFromDB.seasonNumber = body["season"]["seasonNumber"]
                    end

                    if(body["season"]["seasonYear"] != nil)
                        userFromDB.seasonYear = body["season"]["seasonYear"]
                    end
                
                    if(body["season"]["totalGamesThisSeason"] != nil)
                        userFromDB.totalGamesThisSeason = body["season"]["totalGamesThisSeason"]
                    end
                    
                    if(body["season"]["stats"][0]["wins"] != nil)
                        userFromDB.wins1vs1 = body["season"]["stats"][0]["wins"]
                    end
                    
                    if(body["season"]["stats"][0]["games"] != nil)
                        userFromDB.games1vs1 = body["season"]["stats"][0]["games"]
                    end

                    if(body["season"]["stats"][1]["wins"] != nil)
                        userFromDB.wins2vs2 = body["season"]["stats"][1]["wins"]
                    end

                    if(body["season"]["stats"][1]["games"] != nil)
                        userFromDB.games2vs2 = body["season"]["stats"][1]["games"]
                    end
                    
                    if(body["season"]["stats"][2]["wins"] != nil)
                        userFromDB.wins3vs3 = body["season"]["stats"][2]["wins"]
                    end
                    
                    if(body["season"]["stats"][2]["games"] != nil)
                        userFromDB.games3vs3 = body["season"]["stats"][2]["games"]
                    end

                    if(body["season"]["stats"][3]["wins"] != nil)
                        userFromDB.wins4vs4 = body["season"]["stats"][3]["wins"]
                    end
                    
                    if(body["season"]["stats"][3]["games"] != nil)
                        userFromDB.games4vs4 = body["season"]["stats"][3]["games"]
                    end
                    
                    if(body["season"]["stats"][4]["wins"] != nil)
                        userFromDB.winsArchon = body["season"]["stats"][4]["wins"]
                    end
                    
                    if(body["season"]["stats"][4]["games"] != nil)
                        userFromDB.gamesArchon = body["season"]["stats"][4]["games"]
                    end

                    if(body["achievements"]["points"]["totalPoints"] != nil)
                        userFromDB.totalPointsAchievements = body["achievements"]["points"]["totalPoints"]
                    end

                    userFromDB.save
                
                else

                    user = Stat.new

                    user.id = profileId
                    user.region = regionId
    
                    if(body["career"]["primaryRace"] != nil) 
                        user.realm = body["realm"]
                    else
                        user.realm = 0
                    end
    
                    if(body["displayName"] != "")
                        user.displayName = body["displayName"]
                    else
                        user.displayName = "-"
                    end
    
                    if(body["clanName"] != "")
                        user.clanName = body["clanName"]
                    else
                        user.clanName = "-"
                    end
    
                    if(body["clanTag"] != "")
                        user.clanTag = body["clanTag"]
                    else
                        user.clanTag = "-"
                    end
                    if(body["profilePath"] != "")
                        user.profilePath = body["profilePath"]
                    else
                        user.profilePath = "-"
                    end
    
                    if(body["career"]["primaryRace"] != "")
                        user.primaryRace = body["career"]["primaryRace"]
                    else
                        user.primaryRace = "-"
                    end
                    
                    if(body["career"]["terranWins"] != nil)
                        user.terranWins = body["career"]["terranWins"]
                    else
                        user.terranWins = 0
                    end
                    
                    if(body["career"]["protossWins"] != nil)
                        user.protossWins = body["career"]["protossWins"]
                    else
                        user.protossWins = 0
                    end
                    
                    if(body["career"]["zergWins"] != nil)
                        user.zergWins = body["career"]["zergWins"]
                    else
                        user.zergWins = 0
                    end
                    
                    if(body["career"]["highest1v1Rank"] != nil) 
                        user.highest1v1Rank = body["career"]["highest1v1Rank"]
                    else
                        user.highest1v1Rank = "-"
                    end
    
                    if(body["career"]["highestTeamRank"] != nil)
                        user.highestTeamRank = body["career"]["highestTeamRank"]
                    else
                        user.highestTeamRank = "-"
                    end
                    
                    if(body["career"]["seasonTotalGames"] != nil)
                        user.seasonTotalGames = body["career"]["seasonTotalGames"]
                    else
                        user.seasonTotalGames = 0
                    end
                    
                    if(body["career"]["careerTotalGames"] != nil)
                        user.careerTotalGames = body["career"]["careerTotalGames"]
                    else
                        user.careerTotalGames = 0
                    end
    
                    if(body["swarmLevels"]["level"] != nil)
                        user.level = body["swarmLevels"]["level"]
                    else
                        user.level = 0
                    end
    
                    if(body["swarmLevels"]["terran"]["level"] != nil)
                        user.levelTerran = body["swarmLevels"]["terran"]["level"]
                    else
                        user.levelTerran = 0
                    end
                    
                    if(body["swarmLevels"]["terran"]["totalLevelXP"] != nil)
                        user.totalLevelXPTerran = body["swarmLevels"]["terran"]["totalLevelXP"]
                    else
                        user.totalLevelXPTerran = 0
                    end
    
                    if(body["swarmLevels"]["terran"]["currentLevelXP"] != nil)
                        user.currentLevelXPTerran = body["swarmLevels"]["terran"]["currentLevelXP"]
                    else
                        user.currentLevelXPTerran = 0
                    end
    
                    if(body["swarmLevels"]["zerg"]["level"] != nil)
                        user.levelZerg = body["swarmLevels"]["zerg"]["level"]
                    else
                        user.levelZerg = 0
                    end
    
                    if(body["swarmLevels"]["zerg"]["totalLevelXP"] != nil)
                        user.totalLevelXPZerg = body["swarmLevels"]["zerg"]["totalLevelXP"]
                    else
                        user.totalLevelXPZerg = 0
                    end
    
                    if(body["swarmLevels"]["zerg"]["currentLevelXP"] != nil)
                        user.currentLevelXPZerg = body["swarmLevels"]["zerg"]["currentLevelXP"]
                    else
                        user.currentLevelXPZerg = 0
                    end
    
                    if(body["swarmLevels"]["protoss"]["level"] != nil)
                        user.levelProtoss = body["swarmLevels"]["protoss"]["level"]
                    else
                        user.levelProtoss = 0
                    end
    
                    if(body["swarmLevels"]["protoss"]["totalLevelXP"] != nil)
                        user.totalLevelXPProtoss = body["swarmLevels"]["protoss"]["totalLevelXP"]
                    else
                        user.totalLevelXPProtoss = 0
                    end
    
                    if(body["swarmLevels"]["protoss"]["currentLevelXP"] != nil)
                        user.currentLevelXPProtoss = body["swarmLevels"]["protoss"]["currentLevelXP"]
                    else
                        user.currentLevelXPProtoss = 0
                    end
    
                    if(body["season"]["seasonId"] != nil)
                        user.seasonId = body["season"]["seasonId"]
                    else    
                        user.seasonId = 0
                    end
                    
                    if(body["season"]["seasonNumber"] != nil) 
                        user.seasonNumber = body["season"]["seasonNumber"]
                    else
                        user.seasonNumber = 0
                    end
    
                    if(body["season"]["seasonYear"] != nil)
                        user.seasonYear = body["season"]["seasonYear"]
                    else
                        user.seasonYear = 0
                    end
                   
                    if(body["season"]["totalGamesThisSeason"] != nil)
                        user.totalGamesThisSeason = body["season"]["totalGamesThisSeason"]
                    else
                        user.totalGamesThisSeason = 0
                    end
                    
                    if(body["season"]["stats"][0]["wins"] != nil)
                        user.wins1vs1 = body["season"]["stats"][0]["wins"]
                    else
                        user.wins1vs1 = 0
                    end
                    
                    if(body["season"]["stats"][0]["games"] != nil)
                        user.games1vs1 = body["season"]["stats"][0]["games"]
                    else
                        user.games1vs1 = 0
                    end
    
                    if(body["season"]["stats"][1]["wins"] != nil)
                        user.wins2vs2 = body["season"]["stats"][1]["wins"]
                    else
                        user.wins2vs2 = 0
                    end
    
                    if(body["season"]["stats"][1]["games"] != nil)
                        user.games2vs2 = body["season"]["stats"][1]["games"]
                    else
                        user.games2vs2 = 0
                    end
                    
                    if(body["season"]["stats"][2]["wins"] != nil)
                        user.wins3vs3 = body["season"]["stats"][2]["wins"]
                    else
                        user.wins3vs3 = 0
                    end
                    
                    if(body["season"]["stats"][2]["games"] != nil)
                        user.games3vs3 = body["season"]["stats"][2]["games"]
                    else
                        user.games3vs3 = 0
                    end
    
                    if(body["season"]["stats"][3]["wins"] != nil)
                        user.wins4vs4 = body["season"]["stats"][3]["wins"]
                    else
                        user.wins4vs4 = 0
                    end
                    
                    if(body["season"]["stats"][3]["games"] != nil)
                        user.games4vs4 = body["season"]["stats"][3]["games"]
                    else
                        user.games4vs4 = 0
                    end
                    
                    if(body["season"]["stats"][4]["wins"] != nil)
                        user.winsArchon = body["season"]["stats"][4]["wins"]
                    else
                        user.winsArchon = 0
                    end
                    
                    if(body["season"]["stats"][4]["games"] != nil)
                        user.gamesArchon = body["season"]["stats"][4]["games"]
                    else
                        user.gamesArchon = 0
                    end
    
                    if(body["achievements"]["points"]["totalPoints"] != nil)
                        user.totalPointsAchievements = body["achievements"]["points"]["totalPoints"]
                    else
                        user.totalPointsAchievements = 0
                    end
    
                    user.save

                end
            else
                user = Stat.new

                user.id = profileId
                user.region = regionId

                if(body["career"]["primaryRace"] != nil) 
                    user.realm = body["realm"]
                else
                    user.realm = 0
                end

                if(body["displayName"] != nil)
                    user.displayName = body["displayName"]
                else
                    user.displayName = "-"
                end

                if(body["clanName"] != "")
                    user.clanName = body["clanName"]
                else
                    user.clanName = "-"
                end

                if(body["clanTag"] != "")
                    user.clanTag = body["clanTag"]
                else
                    user.clanTag = "-"
                end
                if(body["profilePath"] != nil)
                    user.profilePath = body["profilePath"]
                else
                    user.profilePath = "-"
                end

                if(body["career"]["primaryRace"] != "")
                    user.primaryRace = body["career"]["primaryRace"]
                else
                    user.primaryRace = "-"
                end
                
                if(body["career"]["terranWins"] != nil)
                    user.terranWins = body["career"]["terranWins"]
                else
                    user.terranWins = 0
                end
                
                if(body["career"]["protossWins"] != nil)
                    user.protossWins = body["career"]["protossWins"]
                else
                    user.protossWins = 0
                end
                
                if(body["career"]["zergWins"] != nil)
                    user.zergWins = body["career"]["zergWins"]
                else
                    user.zergWins = 0
                end

                if(body["career"]["highest1v1Rank"] != nil) 
                    user.highest1v1Rank = body["career"]["highest1v1Rank"]
                else
                    user.highest1v1Rank = "-"
                end

                if(body["career"]["highestTeamRank"] != nil)
                    user.highestTeamRank = body["career"]["highestTeamRank"]
                else
                    user.highestTeamRank = "-"
                end
                
                if(body["career"]["seasonTotalGames"] != nil)
                    user.seasonTotalGames = body["career"]["seasonTotalGames"]
                else
                    user.seasonTotalGames = 0
                end
                
                if(body["career"]["careerTotalGames"] != nil)
                    user.careerTotalGames = body["career"]["careerTotalGames"]
                else
                    user.careerTotalGames = 0
                end

                if(body["swarmLevels"]["level"] != nil)
                    user.level = body["swarmLevels"]["level"]
                else
                    user.level = 0
                end

                if(body["swarmLevels"]["terran"]["level"] != nil)
                    user.levelTerran = body["swarmLevels"]["terran"]["level"]
                else
                    user.levelTerran = 0
                end
                
                if(body["swarmLevels"]["terran"]["totalLevelXP"] != nil)
                    user.totalLevelXPTerran = body["swarmLevels"]["terran"]["totalLevelXP"]
                else
                    user.totalLevelXPTerran = 0
                end

                if(body["swarmLevels"]["terran"]["currentLevelXP"] != nil)
                    user.currentLevelXPTerran = body["swarmLevels"]["terran"]["currentLevelXP"]
                else
                    user.currentLevelXPTerran = 0
                end

                if(body["swarmLevels"]["zerg"]["level"] != nil)
                    user.levelZerg = body["swarmLevels"]["zerg"]["level"]
                else
                    user.levelZerg = 0
                end

                if(body["swarmLevels"]["zerg"]["totalLevelXP"] != nil)
                    user.totalLevelXPZerg = body["swarmLevels"]["zerg"]["totalLevelXP"]
                else
                    user.totalLevelXPZerg = 0
                end

                if(body["swarmLevels"]["zerg"]["currentLevelXP"] != nil)
                    user.currentLevelXPZerg = body["swarmLevels"]["zerg"]["currentLevelXP"]
                else
                    user.currentLevelXPZerg = 0
                end

                if(body["swarmLevels"]["protoss"]["level"] != nil)
                    user.levelProtoss = body["swarmLevels"]["protoss"]["level"]
                else
                    user.levelProtoss = 0
                end

                if(body["swarmLevels"]["protoss"]["totalLevelXP"] != nil)
                    user.totalLevelXPProtoss = body["swarmLevels"]["protoss"]["totalLevelXP"]
                else
                    user.totalLevelXPProtoss = 0
                end

                if(body["swarmLevels"]["protoss"]["currentLevelXP"] != nil)
                    user.currentLevelXPProtoss = body["swarmLevels"]["protoss"]["currentLevelXP"]
                else
                    user.currentLevelXPProtoss = 0
                end

                if(body["season"]["seasonId"] != nil)
                    user.seasonId = body["season"]["seasonId"]
                else    
                    user.seasonId = 0
                end
                
                if(body["season"]["seasonNumber"] != nil) 
                    user.seasonNumber = body["season"]["seasonNumber"]
                else
                    user.seasonNumber = 0
                end

                if(body["season"]["seasonYear"] != nil)
                    user.seasonYear = body["season"]["seasonYear"]
                else
                    user.seasonYear = 0
                end
               
                if(body["season"]["totalGamesThisSeason"] != nil)
                    user.totalGamesThisSeason = body["season"]["totalGamesThisSeason"]
                else
                    user.totalGamesThisSeason = 0
                end
                
                if(body["season"]["stats"][0]["wins"] != nil)
                    user.wins1vs1 = body["season"]["stats"][0]["wins"]
                else
                    user.wins1vs1 = 0
                end
                
                if(body["season"]["stats"][0]["games"] != nil)
                    user.games1vs1 = body["season"]["stats"][0]["games"]
                else
                    user.games1vs1 = 0
                end

                if(body["season"]["stats"][1]["wins"] != nil)
                    user.wins2vs2 = body["season"]["stats"][1]["wins"]
                else
                    user.wins2vs2 = 0
                end

                if(body["season"]["stats"][1]["games"] != nil)
                    user.games2vs2 = body["season"]["stats"][1]["games"]
                else
                    user.games2vs2 = 0
                end
                
                if(body["season"]["stats"][2]["wins"] != nil)
                    user.wins3vs3 = body["season"]["stats"][2]["wins"]
                else
                    user.wins3vs3 = 0
                end
                
                if(body["season"]["stats"][2]["games"] != nil)
                    user.games3vs3 = body["season"]["stats"][2]["games"]
                else
                    user.games3vs3 = 0
                end

                if(body["season"]["stats"][3]["wins"] != nil)
                    user.wins4vs4 = body["season"]["stats"][3]["wins"]
                else
                    user.wins4vs4 = 0
                end
                
                if(body["season"]["stats"][3]["games"] != nil)
                    user.games4vs4 = body["season"]["stats"][3]["games"]
                else
                    user.games4vs4 = 0
                end
                
                if(body["season"]["stats"][4]["wins"] != nil)
                    user.winsArchon = body["season"]["stats"][4]["wins"]
                else
                    user.winsArchon = 0
                end
                
                if(body["season"]["stats"][4]["games"] != nil)
                    user.gamesArchon = body["season"]["stats"][4]["games"]
                else
                    user.gamesArchon = 0
                end

                if(body["achievements"]["points"]["totalPoints"] != nil)
                    user.totalPointsAchievements = body["achievements"]["points"]["totalPoints"]
                else
                    user.totalPointsAchievements = 0
                end

                user.save
            end
            #puts "FINE-------------------"
        rescue
            return []
        end
    end
=begin
    def self.ottieniLadders(access_token, regionId, realmId, profileId)
        if access_token == nil
            return nil
        end

        url = URI.parse("https://us.api.blizzard.com/sc2/legacy/profile/#{regionId}/#{realmId}/#{profileId}/ladders")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == "https")

        request = Net::HTTP::Get.new(url.path)
        request["Authorization"] = "Bearer #{access_token}"
        response = http.request(request)
        return [] if response.code == "404"

        begin
#            puts "INIZIO--------------"
            body = JSON.parse(response.body)
            id = profileId
            region = regionId
            puts body
            if body["currentSeason"].size != 0 || body["previousSeason"].size != 0 || body["showcasePlacement"].size != 0
                return body
            else
            end
#            puts "FINE-------------------"
        rescue
            return []
        end
        return []
    end
=end
end

#rails g scaffold Stats id:integer region:integer realm:integer displayName:string clanName:string clanTag:string profilePath:string primaryRace:string terranWins:integer protossWins:integer zergWins:integer highest1v1Rank:string highestTeamRank:string seasonTotalGames:integer careerTotalGames:integer level:integer levelTerran:integer totalLevelXPTerran:integer currentLevelXPTerran:integer levelZerg:integer totalLevelXPZerg:integer currentLevelXPZerg:integer levelProtoss:integer totalLevelXPProtoss:integer currentLevelXPProtoss:integer seasonId:integer seasonNumber:integer seasonYear:integer totalGamesThisSeason:integer wins1vs1:integer games1vs1:integer wins2vs2:integer games2vs2:integer wins3vs3:integer games3vs3:integer wins4vs4:integer games4vs4:integer winsArchon:integer gamesArchon:integer totalPointsAchievements:integer

#Stat.delete_all #DA ELIMINARE
#create_table :stats, id: false, force: :cascade do |t|

'''
id:integer
region:integer
realm:integer
displayName:string
clanName:string
clanTag:string
profilePath:string
primaryRace:string
terranWins:integer
protossWins:integer
zergWins:integer
highest1v1Rank:string
highestTeamRank:string
seasonTotalGames:integer
careerTotalGames:integer
level:integer
levelTerran:integer
totalLevelXPTerran:integer
currentLevelXPTerran:integer
levelZerg:integer
totalLevelXPZerg:integer
currentLevelXPZerg:integer
levelProtoss:integer
totalLevelXPProtoss:integer
currentLevelXPProtoss:integer
seasonId:integer
seasonNumber:integer
seasonYear:integer
totalGamesThisSeason:integer
wins1vs1:integer
games1vs1:integer
wins2vs2:integer
games2vs2:integer
wins3vs3:integer
games3vs3:integer
wins4vs4:integer
games4vs4:integer
winsArchon:integer
gamesArchon:integer
totalPointsAchievements:integer
'''
'''
user.id = 0
user.region = 0
user.realm = 0
user.displayName = 0
user.clanName = 0
user.clanTag = 0
user.profilePath = 0
user.primaryRace = 0
user.terranWins = 0
user.protossWins = 0
user.zergWins = 0
user.highest1v1Rank = 0
user.highestTeamRank = 0
user.seasonTotalGames = 0
user.careerTotalGames = 0
user.level = 0
user.levelTerran = 0
user.totalLevelXPTerran = 0
user.currentLevelXPTerran = 0
user.levelZerg = 0
user.totalLevelXPZerg = 0
user.currentLevelXPZerg = 0
user.levelProtoss = 0
user.totalLevelXPProtoss = 0
user.currentLevelXPProtoss = 0
user.seasonId = 0
user.seasonNumber = 0
user.seasonYear = 0
user.totalGamesThisSeason = 0
user.wins1vs1 = 0
user.games1vs1 = 0
user.wins2vs2 = 0
user.games2vs2 = 0
user.wins3vs3 = 0
user.games3vs3 = 0
user.wins4vs4 = 0
user.games4vs4 = 0
user.winsArchon = 0
user.gamesArchon = 0
user.totalPointsAchievements = 0
'''