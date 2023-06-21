class PagesController < ApplicationController
  def home
    #reset_session

    ###PER FAR FUNZIONARE TUTTO BISOGNA SCRIVERE SUL TERMINALE :
      #1) redis-server su un terminale
      #2) bundle exec sidekiq su un altro terminale
      #3) rails s su un terzo terminale


    Sidekiq::Queue.all.each(&:clear)
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear
    Sidekiq::DeadSet.new.clear
    #BackgroundJob.perform_async(session[:access_token], 4365361, 4365361+1000)
    #BackgroundJob.perform_async(session[:access_token], 4365361+1000, 4365361+2000)
    #BackgroundJob.perform_async(session[:access_token], 4365361+2000, 4365361+3000)
    #BackgroundJob.perform_async(session[:access_token], 4365361+3000, 4365361+4000)
    #BackgroundJob.perform_async(session[:access_token], 4365361+4000, 4365361+5000)
    #BackgroundJob.perform_async(session[:access_token], 4365361+5000, 4365361+6000)
    
    #BackgroundJob.perform_async(session[:access_token], 76000, 78000)
    #BackgroundJob.perform_async(session[:access_token], 78000, 80000)
    #BackgroundJob.perform_async(session[:access_token], 80000, 82000)
    #BackgroundJob.perform_async(session[:access_token], 82000, 84000)
    
    #BackgroundJob.perform_async(session[:access_token], 84000, 86000)
    #BackgroundJob.perform_async(session[:access_token], 86000, 88000)
    #BackgroundJob.perform_async(session[:access_token], 88000, 90000)

  
    #puts "//////////////////"

    #regionIds = ["1,2,3,5"] #the region for the profile 1=US, 2=EU, 3=KO and TW, 5=CN
    #realmIds = ["1","2"]  #the region of the profile
    #profileIds = ["4365361"]
    #res = BattlenetOauthService.ottieniInfoProfilo(session[:access_token], "1", "1", "4365361")

    #for val in (4365361-100)..(4365361+100)
    #  res = BattlenetOauthService.ottieniLadders(session[:access_token], "1", "1", val.to_s)
    #end
    
    
    
      #valori = Stat.pluck(:id) # Estrae tutti i valori della colonna dal database
    #risultato = valori.map { |valore| "\"#{valore}\"" }.join(",") # Formatta i valori nel formato richiesto
    #puts risultato
    #puts "//////////////////"
  end
end
