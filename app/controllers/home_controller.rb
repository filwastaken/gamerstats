class HomeController < ApplicationController
  before_action :authenticate_user!, only: [ :personstats, :update_role, :search ]

  def index
    @result=[]
    ###PER FAR FUNZIONARE TUTTO BISOGNA SCRIVERE SUL TERMINALE :
      #1) redis-server su un terminale
      #2) bundle exec sidekiq su un altro terminale (redis-cli --> flushall)
      #3) rails s su un terzo terminale

    Sidekiq::Queue.all.each(&:clear)
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear
    Sidekiq::DeadSet.new.clear

    last_id = Stat.order(id: :desc).pluck(:uid).first

    last_id == nil ? a = 0 : a = last_id

    interval = 10
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "1")
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "2")
    a = a + interval
    #BackgroundJob.perform_async(session[:access_token], a, a+interval, "3")
    #a = a + interval
    #BackgroundJob.perform_async(session[:access_token], a, a+interval, "4")
    #a = a + interval
    #BackgroundJob.perform_async(session[:access_token], a, a+interval, "5")
    #a = a + interval
    #BackgroundJob.perform_async(session[:access_token], a, a+interval, "6")
    #a = a + interval
    #BackgroundJob.perform_async(session[:access_token], a, a+interval, "7")
    #a = a + interval
    #BackgroundJob.perform_async(session[:access_token], a, a+interval, "8")
    #a = a + interval
  end

  def personstats
  end

  
  def update_role
    @user = User.find(params[:id])
    @user.role = params[:role]
    if @user.save
      redirect_to home_index_path, notice: 'Il ruolo è stato aggiornato con successo.'
    else
      render :edit, alert: 'Si è verificato un errore durante l\'aggiornamento del ruolo.'
    end
  end

  def search
    uid = -1
    if params[:user_uid].to_i == 0
      utente = User.find_by(nickname: params[:user_uid])
      if utente != nil
        uid = utente.uid
        BattlenetOauthService.ottieniProfilo(session[:access_token], utente.uid)
        @results = Stat.find_by(uid: uid)
        render :index
      else
        @result = nil
        render :index
      end
    else
      uid = params[:user_uid]
      BattlenetOauthService.ottieniProfilo(session[:access_token], uid)
      @results = Stat.find_by(uid: uid)
      render :index
    end
  end
end
