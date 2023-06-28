class BackgroundJob
    include Sidekiq::Worker
  
    def perform(access_token, min, max, thread)
      puts "//////////////////"
      regionIds = ["2"]
      realmIds = ["1","2"]
  
      for profileId in min..max
        puts "#{profileId}      thread: #{thread}      #{profileId} / #{max}"
        regionIds.each do |region|
          realmIds.each do |realm|
            res = BattlenetOauthService.ottieniInfoProfilo(access_token, region, realm, profileId)
          end
        end
      end
      puts "//////////////////"
    end
=begin
      stats = Stat.all
      id_list = stats.map(&:id)
      id_list = id_list.uniq
      id_list = id_list.sort
      id_slice = id_list.slice(min,max)

      id_slice.each do |profileId|
        puts profileId
        regionIds.each do |region|
          realmIds.each do |realm|
            res = BattlenetOauthService.ottieniInfoProfilo(access_token, region, realm, profileId)
          end
        end
      end
      puts "//////////////////"
    end
=end
end
  
#res = BattlenetOauthService.ottieniLadders(access_token, region.to_s, realm.to_s, profileId.to_s)
