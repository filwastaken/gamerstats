class BackgroundJob
    include Sidekiq::Worker
  
    def perform(access_token, min, max, thread)
      puts "//////////////////"

      min.each do |profileId|
        puts "#{profileId}      thread: #{thread}"
        BattlenetOauthService.ottieniProfilo(access_token, profileId)
      end

=begin
      for profileId in min..max
        puts "#{profileId}      thread: #{thread}      #{profileId} / #{max}"
        BattlenetOauthService.ottieniProfilo(access_token, profileId)
      end
=end
      puts "//////////////////"
    end
end