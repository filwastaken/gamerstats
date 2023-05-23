class BattlenetOauthService
    require 'net/http'
    require 'openssl'
    require 'uri'
    @colonne = ["id","number","preferredSlot","givenName","name","familyName","role","headshotUrl","eroe","abilityDamageDone","accretionKills","amplificationMatrixAssists","barrageKills","bioticGrenadeKills","blizzardKills","bobKills","carnageKills","chainHooksAttempted","chargedShotKills","coalescenseHealing","concussionMineKills","criticalHits","damageAmplified","damageBlockedSojurn","damageDiscordOrb","damageTaken","deadeyeKills","deathBlossomKills","deaths","dragonbladeKills","dragonstrikeKills","earthshatterKills","earthshatterStuns","eliminations","enemiesChainHooked","enemiesEMPd","enemiesFrozen","enemiesHacked","enemiesSlept","energyMax","finalBlows","focusingBeamKills","graviticFluxKills","gravitonSurgeKills","healingDone","helixRocketKills","heroDamageDone","immortalityFieldDeathsPrevented","inspireUptime","jaggedBladeKills","javelinDamage","jumpPackKills","kitsuneRushAssists","knockbackKills","kunaiKills","lifetimeEnergyAccumulation","meteorStrikeKills","moltenCoreKills","negativeEffectsCleansed","overclockKills","overhealthProvided","piledriverKills","playersKnockedBack","playersResurrected","playersTeleported","primalRageKills","pulseBombKills","pulseBombsAttached","ripTireKills","rocketDirectHits","scopedCriticalHitKills","scopedCriticalHits","scopedHits","selfdestructKills","shotsHit","soloKills","stickyBombsKills","stormArrowKills","tacticalVisorKills","terraSurgeKills","timePlayed","timeSpentOnFire","turretKills","ultimatesNegated","ultsEarned","ultsUsed","wholeHogKills"]


    def self.ottieniId(access_token)
        if access_token == nil
            puts "TOKEN VUOTO COGLIONE---------"
            return nil
        else
            ids = []
            teams = []
            url = URI.parse("https://us.api.blizzard.com/owl/v1/owl2")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = (url.scheme == "https")
            
            request = Net::HTTP::Get.new(url.path)
            
            request['Authorization'] = "Bearer #{access_token}"

            response = http.request(request)

            if response.code != "404"
                return []
            else
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
        end
    end


    def self.ottieniIdDaTeam(access_token, id)
        if access_token == nil
            puts "TOKEN VUOTO COGLIONE---------"
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
            puts "TOKEN VUOTO COGLIONE---------"
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
            puts "TOKEN VUOTO COGLIONE---------"
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


if body["stats"]["id"] == "id"
    user.id = body["stats"]["id"]
end
if body["stats"]["number"] == "number"
    user.number = body["stats"]["number"]
end
if body["stats"]["preferredSlot"] == "preferredSlot"
    user.preferredSlot = body["stats"]["preferredSlot"]
end
if body["stats"]["givenName"] == "givenName"
    user.givenName = body["stats"]["givenName"]
end
if body["stats"]["name"] == "name"
    user.name = body["stats"]["name"]
end
if body["stats"]["familyName"] == "familyName"
    user.familyName = body["stats"]["familyName"]
end
if body["stats"]["role"] == "role"
    user.role = body["stats"]["role"]
end
if body["stats"]["headshotUrl"] == "headshotUrl"
    user.headshotUrl = body["stats"]["headshotUrl"]
end
if body["stats"]["eroe"] == "eroe"
    user.eroe = body["stats"]["eroe"]
end
if body["stats"]["abilityDamageDone"] == "abilityDamageDone"
    user.abilityDamageDone = body["stats"]["abilityDamageDone"]
end
if body["stats"]["accretionKills"] == "accretionKills"
    user.accretionKills = body["stats"]["accretionKills"]
end
if body["stats"]["amplificationMatrixAssists"] == "amplificationMatrixAssists"
    user.amplificationMatrixAssists = body["stats"]["amplificationMatrixAssists"]
end
if body["stats"]["barrageKills"] == "barrageKills"
    user.barrageKills = body["stats"]["barrageKills"]
end
if body["stats"]["bioticGrenadeKills"] == "bioticGrenadeKills"
    user.bioticGrenadeKills = body["stats"]["bioticGrenadeKills"]
end
if body["stats"]["blizzardKills"] == "blizzardKills"
    user.blizzardKills = body["stats"]["blizzardKills"]
end
if body["stats"]["bobKills"] == "bobKills"
    user.bobKills = body["stats"]["bobKills"]
end
if body["stats"]["carnageKills"] == "carnageKills"
    user.carnageKills = body["stats"]["carnageKills"]
end
if body["stats"]["chainHooksAttempted"] == "chainHooksAttempted"
    user.chainHooksAttempted = body["stats"]["chainHooksAttempted"]
end
if body["stats"]["chargedShotKills"] == "chargedShotKills"
    user.chargedShotKills = body["stats"]["chargedShotKills"]
end
if body["stats"]["coalescenseHealing"] == "coalescenseHealing"
    user.coalescenseHealing = body["stats"]["coalescenseHealing"]
end
if body["stats"]["concussionMineKills"] == "concussionMineKills"
    user.concussionMineKills = body["stats"]["concussionMineKills"]
end
if body["stats"]["criticalHits"] == "criticalHits"
    user.criticalHits = body["stats"]["criticalHits"]
end
if body["stats"]["damageAmplified"] == "damageAmplified"
    user.damageAmplified = body["stats"]["damageAmplified"]
end
if body["stats"]["damageBlockedSojurn"] == "damageBlockedSojurn"
    user.damageBlockedSojurn = body["stats"]["damageBlockedSojurn"]
end
if body["stats"]["damageDiscordOrb"] == "damageDiscordOrb"
    user.damageDiscordOrb = body["stats"]["damageDiscordOrb"]
end
if body["stats"]["damageTaken"] == "damageTaken"
    user.damageTaken = body["stats"]["damageTaken"]
end
if body["stats"]["deadeyeKills"] == "deadeyeKills"
    user.deadeyeKills = body["stats"]["deadeyeKills"]
end
if body["stats"]["deathBlossomKills"] == "deathBlossomKills"
    user.deathBlossomKills = body["stats"]["deathBlossomKills"]
end
if body["stats"]["deaths"] == "deaths"
    user.deaths = body["stats"]["deaths"]
end
if body["stats"]["dragonbladeKills"] == "dragonbladeKills"
    user.dragonbladeKills = body["stats"]["dragonbladeKills"]
end
if body["stats"]["dragonstrikeKills"] == "dragonstrikeKills"
    user.dragonstrikeKills = body["stats"]["dragonstrikeKills"]
end
if body["stats"]["earthshatterKills"] == "earthshatterKills"
    user.earthshatterKills = body["stats"]["earthshatterKills"]
end
if body["stats"]["earthshatterStuns"] == "earthshatterStuns"
    user.earthshatterStuns = body["stats"]["earthshatterStuns"]
end
if body["stats"]["eliminations"] == "eliminations"
    user.eliminations = body["stats"]["eliminations"]
end
if body["stats"]["enemiesChainHooked"] == "enemiesChainHooked"
    user.enemiesChainHooked = body["stats"]["enemiesChainHooked"]
end
if body["stats"]["enemiesEMPd"] == "enemiesEMPd"
    user.enemiesEMPd = body["stats"]["enemiesEMPd"]
end
if body["stats"]["enemiesFrozen"] == "enemiesFrozen"
    user.enemiesFrozen = body["stats"]["enemiesFrozen"]
end
if body["stats"]["enemiesHacked"] == "enemiesHacked"
    user.enemiesHacked = body["stats"]["enemiesHacked"]
end
if body["stats"]["enemiesSlept"] == "enemiesSlept"
    user.enemiesSlept = body["stats"]["enemiesSlept"]
end
if body["stats"]["energyMax"] == "energyMax"
    user.energyMax = body["stats"]["energyMax"]
end
if body["stats"]["finalBlows"] == "finalBlows"
    user.finalBlows = body["stats"]["finalBlows"]
end
if body["stats"]["focusingBeamKills"] == "focusingBeamKills"
    user.focusingBeamKills = body["stats"]["focusingBeamKills"]
end
if body["stats"]["graviticFluxKills"] == "graviticFluxKills"
    user.graviticFluxKills = body["stats"]["graviticFluxKills"]
end
if body["stats"]["gravitonSurgeKills"] == "gravitonSurgeKills"
    user.gravitonSurgeKills = body["stats"]["gravitonSurgeKills"]
end
if body["stats"]["healingDone"] == "healingDone"
    user.healingDone = body["stats"]["healingDone"]
end
if body["stats"]["helixRocketKills"] == "helixRocketKills"
    user.helixRocketKills = body["stats"]["helixRocketKills"]
end
if body["stats"]["heroDamageDone"] == "heroDamageDone"
    user.heroDamageDone = body["stats"]["heroDamageDone"]
end
if body["stats"]["immortalityFieldDeathsPrevented"] == "immortalityFieldDeathsPrevented"
    user.immortalityFieldDeathsPrevented = body["stats"]["immortalityFieldDeathsPrevented"]
end
if body["stats"]["inspireUptime"] == "inspireUptime"
    user.inspireUptime = body["stats"]["inspireUptime"]
end
if body["stats"]["jaggedBladeKills"] == "jaggedBladeKills"
    user.jaggedBladeKills = body["stats"]["jaggedBladeKills"]
end
if body["stats"]["javelinDamage"] == "javelinDamage"
    user.javelinDamage = body["stats"]["javelinDamage"]
end
if body["stats"]["jumpPackKills"] == "jumpPackKills"
    user.jumpPackKills = body["stats"]["jumpPackKills"]
end
if body["stats"]["kitsuneRushAssists"] == "kitsuneRushAssists"
    user.kitsuneRushAssists = body["stats"]["kitsuneRushAssists"]
end
if body["stats"]["knockbackKills"] == "knockbackKills"
    user.knockbackKills = body["stats"]["knockbackKills"]
end
if body["stats"]["kunaiKills"] == "kunaiKills"
    user.kunaiKills = body["stats"]["kunaiKills"]
end
if body["stats"]["lifetimeEnergyAccumulation"] == "lifetimeEnergyAccumulation"
    user.lifetimeEnergyAccumulation = body["stats"]["lifetimeEnergyAccumulation"]
end
if body["stats"]["meteorStrikeKills"] == "meteorStrikeKills"
    user.meteorStrikeKills = body["stats"]["meteorStrikeKills"]
end
if body["stats"]["moltenCoreKills"] == "moltenCoreKills"
    user.moltenCoreKills = body["stats"]["moltenCoreKills"]
end
if body["stats"]["negativeEffectsCleansed"] == "negativeEffectsCleansed"
    user.negativeEffectsCleansed = body["stats"]["negativeEffectsCleansed"]
end
if body["stats"]["overclockKills"] == "overclockKills"
    user.overclockKills = body["stats"]["overclockKills"]
end
if body["stats"]["overhealthProvided"] == "overhealthProvided"
    user.overhealthProvided = body["stats"]["overhealthProvided"]
end
if body["stats"]["piledriverKills"] == "piledriverKills"
    user.piledriverKills = body["stats"]["piledriverKills"]
end
if body["stats"]["playersKnockedBack"] == "playersKnockedBack"
    user.playersKnockedBack = body["stats"]["playersKnockedBack"]
end
if body["stats"]["playersResurrected"] == "playersResurrected"
    user.playersResurrected = body["stats"]["playersResurrected"]
end
if body["stats"]["playersTeleported"] == "playersTeleported"
    user.playersTeleported = body["stats"]["playersTeleported"]
end
if body["stats"]["primalRageKills"] == "primalRageKills"
    user.primalRageKills = body["stats"]["primalRageKills"]
end
if body["stats"]["pulseBombKills"] == "pulseBombKills"
    user.pulseBombKills = body["stats"]["pulseBombKills"]
end
if body["stats"]["pulseBombsAttached"] == "pulseBombsAttached"
    user.pulseBombsAttached = body["stats"]["pulseBombsAttached"]
end
if body["stats"]["ripTireKills"] == "ripTireKills"
    user.ripTireKills = body["stats"]["ripTireKills"]
end
if body["stats"]["rocketDirectHits"] == "rocketDirectHits"
    user.rocketDirectHits = body["stats"]["rocketDirectHits"]
end
if body["stats"]["scopedCriticalHitKills"] == "scopedCriticalHitKills"
    user.scopedCriticalHitKills = body["stats"]["scopedCriticalHitKills"]
end
if body["stats"]["scopedCriticalHits"] == "scopedCriticalHits"
    user.scopedCriticalHits = body["stats"]["scopedCriticalHits"]
end
if body["stats"]["scopedHits"] == "scopedHits"
    user.scopedHits = body["stats"]["scopedHits"]
end
if body["stats"]["selfdestructKills"] == "selfdestructKills"
    user.selfdestructKills = body["stats"]["selfdestructKills"]
end
if body["stats"]["shotsHit"] == "shotsHit"
    user.shotsHit = body["stats"]["shotsHit"]
end
if body["stats"]["soloKills"] == "soloKills"
    user.soloKills = body["stats"]["soloKills"]
end
if body["stats"]["stickyBombsKills"] == "stickyBombsKills"
    user.stickyBombsKills = body["stats"]["stickyBombsKills"]
end
if body["stats"]["stormArrowKills"] == "stormArrowKills"
    user.stormArrowKills = body["stats"]["stormArrowKills"]
end
if body["stats"]["tacticalVisorKills"] == "tacticalVisorKills"
    user.tacticalVisorKills = body["stats"]["tacticalVisorKills"]
end
if body["stats"]["terraSurgeKills"] == "terraSurgeKills"
    user.terraSurgeKills = body["stats"]["terraSurgeKills"]
end
if body["stats"]["timePlayed"] == "timePlayed"
    user.timePlayed = body["stats"]["timePlayed"]
end
if body["stats"]["timeSpentOnFire"] == "timeSpentOnFire"
    user.timeSpentOnFire = body["stats"]["timeSpentOnFire"]
end
if body["stats"]["turretKills"] == "turretKills"
    user.turretKills = body["stats"]["turretKills"]
end
if body["stats"]["ultimatesNegated"] == "ultimatesNegated"
    user.ultimatesNegated = body["stats"]["ultimatesNegated"]
end
if body["stats"]["ultsEarned"] == "ultsEarned"
    user.ultsEarned = body["stats"]["ultsEarned"]
end
if body["stats"]["ultsUsed"] == "ultsUsed"
    user.ultsUsed = body["stats"]["ultsUsed"]
end
if body["stats"]["wholeHogKills"] == "wholeHogKills"
   user.wholeHogKills = body["stats"]["wholeHogKills"]
end


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