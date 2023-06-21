class BattlenetOauthService
    require 'net/http'
    require 'openssl'
    require 'uri'

    colonne = ["id", "realm", "displayName", "clanName", "clanTag", "profilePath", "primaryRace", "terranWins","protossWins","zergWins","highest1v1Rank","highestTeamRank","seasonTotalGames","careerTotalGames","level","levelTerran","totalLevelXPTerran","currentLevelXPTerran","levelZerg","totalLevelXPZerg","currentLevelXPZerg","levelProtoss","totalLevelXPProtoss","currentLevelXPProtoss","seasonId","seasonNumber","seasonYear","totalGamesThisSeason","wins1vs1","games1vs1","wins2vs2","games2vs2","wins3vs3","games3vs3","wins4vs4","games4vs4","winsArchon","gamesArchon","totalPointsAchievements"]

    def self.ottieniInfoProfilo(access_token, regionId, realmId, profileId)
        if access_token == nil
            return nil
        end
        puts "#{regionId} #{realmId} #{profileId}"

        url = URI.parse("https://us.api.blizzard.com/sc2/legacy/profile/#{regionId}/#{realmId}/#{profileId}")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == "https")

        request = Net::HTTP::Get.new(url.path)
        request["Authorization"] = "Bearer #{access_token}"
        response = http.request(request)

        return [] if response.code == "404"

        begin
            puts "INIZIO--------------"
            body = JSON.parse(response.body)
            id = profileId
            region = regionId
            realm = body["realm"]
            displayName = body["displayName"]
            clanName = body["clanName"]
            clanTag = body["clanTag"]
            profilePath = body["profilePath"]

            primaryRace = body["career"]["primaryRace"]
            terranWins = body["career"]["terranWins"]
            protossWins = body["career"]["protossWins"]
            zergWins = body["career"]["zergWins"]
            highest1v1Rank = body["career"]["highest1v1Rank"]
            highestTeamRank = body["career"]["highestTeamRank"]
            seasonTotalGames = body["career"]["seasonTotalGames"]
            careerTotalGames = body["career"]["careerTotalGames"]
            
            level = body["swarmLevels"]["level"]
            levelTerran = body["swarmLevels"]["terran"]["level"]
            totalLevelXPTerran = body["swarmLevels"]["terran"]["totalLevelXP"]
            currentLevelXPTerran = body["swarmLevels"]["terran"]["currentLevelXP"]
            levelZerg = body["swarmLevels"]["zerg"]["level"]
            totalLevelXPZerg = body["swarmLevels"]["zerg"]["totalLevelXP"]
            currentLevelXPZerg = body["swarmLevels"]["zerg"]["currentLevelXP"]
            levelProtoss = body["swarmLevels"]["protoss"]["level"]
            totalLevelXPProtoss = body["swarmLevels"]["protoss"]["totalLevelXP"]
            currentLevelXPProtoss = body["swarmLevels"]["protoss"]["currentLevelXP"]

            seasonId = body["season"]["seasonId"]
            seasonNumber = body["season"]["seasonNumber"]
            seasonYear = body["season"]["seasonYear"]
            totalGamesThisSeason = body["season"]["totalGamesThisSeason"]
            wins1vs1 = body["season"]["stats"][0]["wins"]
            games1vs1 = body["season"]["stats"][0]["games"]
            wins2vs2 = body["season"]["stats"][1]["wins"]
            games2vs2 = body["season"]["stats"][1]["games"]
            wins3vs3 = body["season"]["stats"][2]["wins"]
            games3vs3 = body["season"]["stats"][2]["games"]
            wins4vs4 = body["season"]["stats"][3]["wins"]
            games4vs4 = body["season"]["stats"][3]["games"]
            winsArchon = body["season"]["stats"][4]["wins"]
            gamesArchon = body["season"]["stats"][4]["games"]
            totalPointsAchievements = body["achievements"]["points"]["totalPoints"]



            puts "FINE-------------------"
        rescue
            return []
        end
    end

    def self.ottieniLadders(access_token, regionId, realmId, profileId)
        if access_token == nil
            return nil
        end
        #puts "#{regionId} #{realmId} #{profileId}"

        url = URI.parse("https://us.api.blizzard.com/sc2/legacy/profile/#{regionId}/#{realmId}/#{profileId}/ladders")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == "https")

        request = Net::HTTP::Get.new(url.path)
        request["Authorization"] = "Bearer #{access_token}"
        response = http.request(request)
        #puts response
        return [] if response.code == "404"

        begin
            #puts "INIZIO--------------"
            body = JSON.parse(response.body)
            id = profileId
            region = regionId
            if body["currentSeason"].size != 0 || body["previousSeason"].size != 0 || body["showcasePlacement"].size != 0
                if(body["currentSeason"]["nonRanked"].size != 0 || body["previousSeason"]["nonRanked"].size != 0)
                    return body
                end
            else
            end
            #puts "FINE-------------------"
        rescue
            return []
        end
        return []
    end
end

#rails g scaffold Stats id:integer number:integer preferredSlot:integer givenName:string name:string familyName:string role:string headshotUrl:string eroe:string abilityDamageDone:integer accretionKills:integer amplificationMatrixAssists:integer barrageKills:integer bioticGrenadeKills:integer blizzardKills:integer bobKills:integer carnageKills:integer chainHooksAttempted:integer chargedShotKills:integer coalescenseHealing:integer concussionMineKills:integer criticalHits:integer damageAmplified:integer damageBlockedSojurn:integer damageDiscordOrb:integer damageTaken:integer deadeyeKills:integer deathBlossomKills:integer deaths:integer dragonbladeKills:integer dragonstrikeKills:integer earthshatterKills:integer earthshatterStuns:integer eliminations:integer enemiesChainHooked:integer enemiesEMPd:integer enemiesFrozen:integer enemiesHacked:integer enemiesSlept:integer energyMax:integer finalBlows:integer focusingBeamKills:integer graviticFluxKills:integer gravitonSurgeKills:integer healingDone:integer helixRocketKills:integer heroDamageDone:integer immortalityFieldDeathsPrevented:integer inspireUptime:integer jaggedBladeKills:integer javelinDamage:integer jumpPackKills:integer kitsuneRushAssists:integer knockbackKills:integer kunaiKills:integer lifetimeEnergyAccumulation:integer meteorStrikeKills:integer moltenCoreKills:integer negativeEffectsCleansed:integer overclockKills:integer overhealthProvided:integer piledriverKills:integer playersKnockedBack:integer playersResurrected:integer playersTeleported:integer primalRageKills:integer pulseBombKills:integer pulseBombsAttached:integer ripTireKills:integer rocketDirectHits:integer scopedCriticalHitKills:integer scopedCriticalHits:integer scopedHits:integer selfdestructKills:integer shotsHit:integer soloKills:integer stickyBombsKills:integer stormArrowKills:integer tacticalVisorKills:integer terraSurgeKills:integer timePlayed:integer timeSpentOnFire:integer turretKills:integer ultimatesNegated:integer ultsEarned:integer ultsUsed:integer wholeHogKills:integer


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
highest1v1Rank:integer
highestTeamRank:integer
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