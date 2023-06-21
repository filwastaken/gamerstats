class BackgroundJob
    include Sidekiq::Worker
  
    def perform(access_token, min, max)
      puts "//////////////////"
      regionIds = ["1,2,3,5"] #the region for the profile 1=US, 2=EU, 3=KO and TW, 5=CN
      realmIds = ["1","2"]  #the region of the profile
      profileIds = ["4365361"]
      #res = BattlenetOauthService.ottieniInfoProfilo(session[:access_token], "1", "1", "4365361")
  
      for val in min..max
        #puts val
        res = BattlenetOauthService.ottieniLadders(access_token, "1", "1", val.to_s)
        if res.size != 0
          puts res
        end
      end
      puts "//////////////////"
    end
end
  