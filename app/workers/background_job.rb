class BackgroundJob
    include Sidekiq::Worker
    def perform(access_token, min, max, thread)
      for profileId in min..max
        BattlenetOauthService.ottieniProfilo(access_token, profileId)
      end
      duplicates = Stat.group(:uid).having("COUNT(*) > 1")
      duplicates.each do |duplicate|
        duplicate_items = Stat.where(uid: duplicate.uid).order(:id)
        duplicate_items.offset(1).destroy_all
      end
    end
end