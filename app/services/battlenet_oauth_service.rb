class BattlenetOauthService
    require 'net/http'
    require 'openssl'
    require 'uri'
    @colonne = ["id","number","preferredSlot","givenName","name","familyName","role","headshotUrl","eroe","abilityDamageDone","accretionKills","amplificationMatrixAssists","barrageKills","bioticGrenadeKills","blizzardKills","bobKills","carnageKills","chainHooksAttempted","chargedShotKills","coalescenseHealing","concussionMineKills","criticalHits","damageAmplified","damageBlockedSojurn","damageDiscordOrb","damageTaken","deadeyeKills","deathBlossomKills","deaths","dragonbladeKills","dragonstrikeKills","earthshatterKills","earthshatterStuns","eliminations","enemiesChainHooked","enemiesEMPd","enemiesFrozen","enemiesHacked","enemiesSlept","energyMax","finalBlows","focusingBeamKills","graviticFluxKills","gravitonSurgeKills","healingDone","helixRocketKills","heroDamageDone","immortalityFieldDeathsPrevented","inspireUptime","jaggedBladeKills","javelinDamage","jumpPackKills","kitsuneRushAssists","knockbackKills","kunaiKills","lifetimeEnergyAccumulation","meteorStrikeKills","moltenCoreKills","negativeEffectsCleansed","overclockKills","overhealthProvided","piledriverKills","playersKnockedBack","playersResurrected","playersTeleported","primalRageKills","pulseBombKills","pulseBombsAttached","ripTireKills","rocketDirectHits","scopedCriticalHitKills","scopedCriticalHits","scopedHits","selfdestructKills","shotsHit","soloKills","stickyBombsKills","stormArrowKills","tacticalVisorKills","terraSurgeKills","timePlayed","timeSpentOnFire","turretKills","ultimatesNegated","ultsEarned","ultsUsed","wholeHogKills"]


    def self.ottieniId(access_token)
        if access_token == nil
            return nil
        end

        ids = []; teams = []
        url = URI.parse("https://us.api.blizzard.com/owl/v1/owl2")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == "https")

        request = Net::HTTP::Get.new(url.path)
        request['Authorization'] = "Bearer #{access_token}"
        response = http.request(request)

        return [] if response.code != "404"

        begin
            body = JSON.parse(response.body)
            players = body["players"]
            players.each do |id, carattPlayer|
                ids.push(id.to_i)
                teams.push(body["players"][id]["teams"][0]["id"].to_i)
            end

            body["teams"].keys.each do |id|
                body["teams"][id]["roster"].each do |giocatore|
                    ids.push(giocatore.to_i)
                end
            end

            body["matches"].keys.each do |partita|
                body["matches"][partita]["teams"].keys.each do |id|
                    teams.push(id.to_i)
                end
                body["matches"][partita]["players"].each do |id|
                    ids.push(id.to_i)
                end
            end

            ids = ids.uniq
            ids = ids.sort
            teams = teams.uniq
            teams = teams.sort

            ris = [ids, teams]
            return ris
        rescue
            return []
        end
    end


    def self.ottieniIdDaTeam(access_token, id)
        if access_token == nil
            return nil
        else
            ids = []
            url = URI.parse("https://us.api.blizzard.com/owl/v1/teams/#{id}")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = (url.scheme == "https")
            
            request = Net::HTTP::Get.new(url.path)
            
            request['Authorization'] = "Bearer #{access_token}"

            response = http.request(request)
            
            begin
                body = JSON.parse(response.body)
                body["roster"].each do |giocatore|
                    ids.push(giocatore.to_i)
                end
            rescue JSON::ParserError => e
                return ids
            end
            ids = ids.uniq
            ids = ids.sort
            return ids
        end
    end


    def self.infoId(access_token, id)
        if access_token == nil
            return nil
        else
            url = URI.parse("https://us.api.blizzard.com/owl/v1/players/#{id}")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = (url.scheme == "https")
            
            request = Net::HTTP::Get.new(url.path)
            
            request['Authorization'] = "Bearer #{access_token}"

            response = http.request(request)
            puts response
            if(response.code == "404")
                return nil
            else
                begin
                    body = JSON.parse(response.body)
                    if Stat.exists?(id: id)
                        userFromDB = Stat.find_by(id: id)

                        body["stats"].keys.each do |colonna|
                            userFromDB[colonna] = body["stats"][colonna]
                        end
                        userFromDB.save
                    else
                        user = Stat.new
                        user.id = id
                        user.number = body["number"]
                        user.preferredSlot = body["preferredSlot"]
                        user.givenName = body["givenName"]
                        user.name = body["name"]
                        user.familyName = body["familyName"]
                        user.role = body["role"]
                        user.headshotUrl = body["headshotUrl"]

                        body["stats"].keys.each do |colonna|
                            user[colonna] = body["stats"][colonna]
                        end
                        @colonne.each do |elem|
                            if user[elem] == nil
                                if elem != "eroe"
                                    user[elem] = 0
                                else
                                    user[elem] = ""
                                end
                            end
                        end
                        user.save
                    end
                rescue
                    puts "errore"
                end
            end
        end
    end

    def self.infoEroiId(access_token, id)
        if access_token == nil
            return nil
        else
            url = URI.parse("https://us.api.blizzard.com/owl/v1/players/#{id}")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = (url.scheme == "https")
            
            request = Net::HTTP::Get.new(url.path)
            
            request['Authorization'] = "Bearer #{access_token}"

            response = http.request(request)
            if(response.code == "404")
                return nil
            else
                begin
                    body = JSON.parse(response.body)
                    body["heroes"].keys.each do |eroe|
                        if Stat.exists?(id: id, eroe: eroe)
                            userFromDB = Stat.find_by(id: id, eroe: eroe)
                            body["heroes"][eroe].keys.each do |colonna|
                                userFromDB[colonna] = body["heroes"][eroe][colonna]
                            end
                            userFromDB.save
                        else
                            user = Stat.new
                            user.id = id
                            user.number = body["number"]
                            user.preferredSlot = body["preferredSlot"]
                            user.givenName = body["givenName"]
                            user.name = body["name"]
                            user.familyName = body["familyName"]
                            user.role = body["role"]
                            user.headshotUrl = body["headshotUrl"]

                            body["stats"].keys.each do |colonna|
                                user[colonna] = body["heroes"][eroe][colonna]
                            end
                            @colonne.each do |elem|
                                if user[elem] == nil
                                    if elem != "eroe"
                                        user[elem] = 0
                                    else
                                        user[elem] = eroe
                                    end
                                end
                            end
                            user.save
                        end
                    end
                rescue
                    puts "errore"
                end
            end
        end
    end
end

#rails g scaffold Stats id:integer number:integer preferredSlot:integer givenName:string name:string familyName:string role:string headshotUrl:string eroe:string abilityDamageDone:integer accretionKills:integer amplificationMatrixAssists:integer barrageKills:integer bioticGrenadeKills:integer blizzardKills:integer bobKills:integer carnageKills:integer chainHooksAttempted:integer chargedShotKills:integer coalescenseHealing:integer concussionMineKills:integer criticalHits:integer damageAmplified:integer damageBlockedSojurn:integer damageDiscordOrb:integer damageTaken:integer deadeyeKills:integer deathBlossomKills:integer deaths:integer dragonbladeKills:integer dragonstrikeKills:integer earthshatterKills:integer earthshatterStuns:integer eliminations:integer enemiesChainHooked:integer enemiesEMPd:integer enemiesFrozen:integer enemiesHacked:integer enemiesSlept:integer energyMax:integer finalBlows:integer focusingBeamKills:integer graviticFluxKills:integer gravitonSurgeKills:integer healingDone:integer helixRocketKills:integer heroDamageDone:integer immortalityFieldDeathsPrevented:integer inspireUptime:integer jaggedBladeKills:integer javelinDamage:integer jumpPackKills:integer kitsuneRushAssists:integer knockbackKills:integer kunaiKills:integer lifetimeEnergyAccumulation:integer meteorStrikeKills:integer moltenCoreKills:integer negativeEffectsCleansed:integer overclockKills:integer overhealthProvided:integer piledriverKills:integer playersKnockedBack:integer playersResurrected:integer playersTeleported:integer primalRageKills:integer pulseBombKills:integer pulseBombsAttached:integer ripTireKills:integer rocketDirectHits:integer scopedCriticalHitKills:integer scopedCriticalHits:integer scopedHits:integer selfdestructKills:integer shotsHit:integer soloKills:integer stickyBombsKills:integer stormArrowKills:integer tacticalVisorKills:integer terraSurgeKills:integer timePlayed:integer timeSpentOnFire:integer turretKills:integer ultimatesNegated:integer ultsEarned:integer ultsUsed:integer wholeHogKills:integer
'''
id
number
preferredSlot
givenName
name
familyName
role
headshotUrl
eroe
abilityDamageDone
accretionKills
amplificationMatrixAssists
barrageKills
bioticGrenadeKills
blizzardKills
bobKills
carnageKills
chainHooksAttempted
chargedShotKills
coalescenseHealing
concussionMineKills
criticalHits
damageAmplified
damageBlockedSojurn
damageDiscordOrb
damageTaken
deadeyeKills
deathBlossomKills
deaths
dragonbladeKills
dragonstrikeKills
earthshatterKills
earthshatterStuns
eliminations
enemiesChainHooked
enemiesEMPd
enemiesFrozen
enemiesHacked
enemiesSlept
energyMax
finalBlows
focusingBeamKills
graviticFluxKills
gravitonSurgeKills
healingDone
helixRocketKills
heroDamageDone
immortalityFieldDeathsPrevented
inspireUptime
jaggedBladeKills
javelinDamage
jumpPackKills
kitsuneRushAssists
knockbackKills
kunaiKills
lifetimeEnergyAccumulation
meteorStrikeKills
moltenCoreKills
negativeEffectsCleansed
overclockKills
overhealthProvided
piledriverKills
playersKnockedBack
playersResurrected
playersTeleported
primalRageKills
pulseBombKills
pulseBombsAttached
ripTireKills
rocketDirectHits
scopedCriticalHitKills
scopedCriticalHits
scopedHits
selfdestructKills
shotsHit
soloKills
stickyBombsKills
stormArrowKills
tacticalVisorKills
terraSurgeKills
timePlayed
timeSpentOnFire
turretKills
ultimatesNegated
ultsEarned
ultsUsed
wholeHogKills



"id"
"number"
"preferredSlot"
"givenName"
"name"
"familyName"
"role"
"headshotUrl"
"eroe"
"abilityDamageDone"
"accretionKills"
"amplificationMatrixAssists"
"barrageKills"
"bioticGrenadeKills"
"blizzardKills"
"bobKills"
"carnageKills"
"chainHooksAttempted"
"chargedShotKills"
"coalescenseHealing"
"concussionMineKills"
"criticalHits"
"damageAmplified"
"damageBlockedSojurn"
"damageDiscordOrb"
"damageTaken"
"deadeyeKills"
"deathBlossomKills"
"deaths"
"dragonbladeKills"
"dragonstrikeKills"
"earthshatterKills"
"earthshatterStuns"
"eliminations"
"enemiesChainHooked"
"enemiesEMPd"
"enemiesFrozen"
"enemiesHacked"
"enemiesSlept"
"energyMax"
"finalBlows"
"focusingBeamKills"
"graviticFluxKills"
"gravitonSurgeKills"
"healingDone"
"helixRocketKills"
"heroDamageDone"
"immortalityFieldDeathsPrevented"
"inspireUptime"
"jaggedBladeKills"
"javelinDamage"
"jumpPackKills"
"kitsuneRushAssists"
"knockbackKills"
"kunaiKills"
"lifetimeEnergyAccumulation"
"meteorStrikeKills"
"moltenCoreKills"
"negativeEffectsCleansed"
"overclockKills"
"overhealthProvided"
"piledriverKills"
"playersKnockedBack"
"playersResurrected"
"playersTeleported"
"primalRageKills"
"pulseBombKills"
"pulseBombsAttached"
"ripTireKills"
"rocketDirectHits"
"scopedCriticalHitKills"
"scopedCriticalHits"
"scopedHits"
"selfdestructKills"
"shotsHit"
"soloKills"
"stickyBombsKills"
"stormArrowKills"
"tacticalVisorKills"
"terraSurgeKills"
"timePlayed"
"timeSpentOnFire"
"turretKills"
"ultimatesNegated"
"ultsEarned"
"ultsUsed"
"wholeHogKills"


["id"]
["number"]
["preferredSlot"]
["givenName"]
["name"]
["familyName"]
["role"]
["headshotUrl"]
["eroe"]
["abilityDamageDone"]
["accretionKills"]
["amplificationMatrixAssists"]
["barrageKills"]
["bioticGrenadeKills"]
["blizzardKills"]
["bobKills"]
["carnageKills"]
["chainHooksAttempted"]
["chargedShotKills"]
["coalescenseHealing"]
["concussionMineKills"]
["criticalHits"]
["damageAmplified"]
["damageBlockedSojurn"]
["damageDiscordOrb"]
["damageTaken"]
["deadeyeKills"]
["deathBlossomKills"]
["deaths"]
["dragonbladeKills"]
["dragonstrikeKills"]
["earthshatterKills"]
["earthshatterStuns"]
["eliminations"]
["enemiesChainHooked"]
["enemiesEMPd"]
["enemiesFrozen"]
["enemiesHacked"]
["enemiesSlept"]
["energyMax"]
["finalBlows"]
["focusingBeamKills"]
["graviticFluxKills"]
["gravitonSurgeKills"]
["healingDone"]
["helixRocketKills"]
["heroDamageDone"]
["immortalityFieldDeathsPrevented"]
["inspireUptime"]
["jaggedBladeKills"]
["javelinDamage"]
["jumpPackKills"]
["kitsuneRushAssists"]
["knockbackKills"]
["kunaiKills"]
["lifetimeEnergyAccumulation"]
["meteorStrikeKills"]
["moltenCoreKills"]
["negativeEffectsCleansed"]
["overclockKills"]
["overhealthProvided"]
["piledriverKills"]
["playersKnockedBack"]
["playersResurrected"]
["playersTeleported"]
["primalRageKills"]
["pulseBombKills"]
["pulseBombsAttached"]
["ripTireKills"]
["rocketDirectHits"]
["scopedCriticalHitKills"]
["scopedCriticalHits"]
["scopedHits"]
["selfdestructKills"]
["shotsHit"]
["soloKills"]
["stickyBombsKills"]
["stormArrowKills"]
["tacticalVisorKills"]
["terraSurgeKills"]
["timePlayed"]
["timeSpentOnFire"]
["turretKills"]
["ultimatesNegated"]
["ultsEarned"]
["ultsUsed"]
["wholeHogKills"]
'''