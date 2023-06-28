class HomeController < ApplicationController
  def index
    #reset_session

    ###PER FAR FUNZIONARE TUTTO BISOGNA SCRIVERE SUL TERMINALE :
      #1) redis-server su un terminale
      #2) bundle exec sidekiq su un altro terminale
      #3) rails s su un terzo terminale

    Sidekiq::Queue.all.each(&:clear)
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear
    Sidekiq::DeadSet.new.clear
=begin
    a = 800
    interval = 50
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
=end
    #valori = Stat.pluck(:id) # Estrae tutti i valori della colonna dal database
    #risultato = valori.map { |valore| "\"#{valore}\"" }.join(",") # Formatta i valori nel formato richiesto
    #puts risultato
  end

  def personstats
  end
  
  def update_role
    @user = User.find(params[:id])
    @user.role = params[:role]
    if @user.save
      redirect_to home_index_path, notice: 'Il ruolo è stato aggiornato con successo. '
    else
      render :edit, alert: 'Si è verificato un errore durante l\'aggiornamento del ruolo.'
    end
  end
end
