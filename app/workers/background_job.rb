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
            BattlenetOauthService.ottieniProfilo(access_token, profileId)
          end
        end
      end
      puts "//////////////////"
    end
end