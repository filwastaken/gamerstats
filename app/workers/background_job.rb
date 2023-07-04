class BackgroundJob
  include Sidekiq::Worker

  def perform(access_token, min, max, thread, threads, intervallo)
    puts "//////////////////"
    min.each do |profileId|
      puts "#{profileId}      thread: #{thread}"
      BattlenetOauthService.ottieniProfilo(access_token, profileId)
    end
    puts "//////////////////"
  end
end



=begin
class BackgroundJob
    include Sidekiq::Worker
  
    def perform(access_token, min, max, thread, threads, intervallo)
      puts "//////////////////"

      for profileId in min..max
        puts "#{profileId}      thread: #{thread}      #{profileId} / #{max}    CICLO 1"
        BattlenetOauthService.ottieniProfilo(access_token, profileId)
      end

      #if(max+intervallo*threads < 2321)
      SecondJob.perform_async(access_token, max+intervallo*threads, max+intervallo*threads+intervallo, thread, threads, intervallo)
      #end  
      puts "//////////////////"
    end
end

class SecondJob
  include Sidekiq::Worker

  def perform(access_token, min, max, thread, threads, intervallo)
    puts "//////////////////"

      for profileId in min..max
        puts "#{profileId}      thread: #{thread}      #{profileId} / #{max}       CICLO 2"
        BattlenetOauthService.ottieniProfilo(access_token, profileId)
      end

    #if(max+intervallo*threads < 2321)
    BackgroundJob.perform_async(access_token, max+intervallo*threads, max+intervallo*threads+intervallo, thread, threads, intervallo)
    #end
    puts "//////////////////"
  end
end
=end