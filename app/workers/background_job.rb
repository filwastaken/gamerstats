=begin

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
=end



class BackgroundJob
    include Sidekiq::Worker
    def perform(access_token, min, max, thread)
      puts "//////////////////"
      for profileId in min..max
        puts "#{profileId}      thread: #{thread}      #{profileId} / #{max}"
        BattlenetOauthService.ottieniProfilo(access_token, profileId)
      end
      duplicates = Stat.group(:uid).having("COUNT(*) > 1")
      duplicates.each do |duplicate|
        duplicate_items = Stat.where(uid: duplicate.uid).order(:id)
        duplicate_items.offset(1).destroy_all
      end
      puts "//////////////////"
    end
end