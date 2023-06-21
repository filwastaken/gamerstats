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

    a = 0
    interval = 100
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "1")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "2")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "3")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "4")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "5")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "6")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "7")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "8")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "9")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "10")  #1000


  
    #puts "//////////////////"

      #valori = Stat.pluck(:id) # Estrae tutti i valori della colonna dal database
    #risultato = valori.map { |valore| "\"#{valore}\"" }.join(",") # Formatta i valori nel formato richiesto
    #puts risultato
    #puts "//////////////////"
  end
end
