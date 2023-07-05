class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy abbandona ]
  before_action :authenticate_user!

  # GET /teams or /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1 or /teams/1.json
  def show
    
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    giocatori = [team_params[:giocatore1]]
    if team_params[:giocatore2] != ""
      giocatori.append(team_params[:giocatore2])
    end

    if team_params[:giocatore3] != ""
      giocatori.append(team_params[:giocatore3])
    end

    if team_params[:giocatore4] != ""
      giocatori.append(team_params[:giocatore4])
    end

    if(giocatori.length != giocatori.uniq.length)
      flash[:notice] = "Non puoi mettere due volte lo stesso id"
      redirect_to new_team_path
      return
    end

    if(giocatori.length < 2)
      flash[:notice] = "Un team deve essere composto da almeno due giocatori!"
      redirect_to new_team_path
    end

    # Removing the first element from the array
    giocatori.shift
    giocatori.sort!

    while giocatori.length < 3
      giocatori.append("")
    end

    teamparams = {"nome_team" => team_params[:nome_team], "giocatore1" => team_params[:giocatore1], "giocatore2" => giocatori[0], "giocatore3" => giocatori[1], "giocatore4" => giocatori[2]}

    @team = Team.new(teamparams)

    if Team.exists?(giocatore1: @team.giocatore1, giocatore2: @team.giocatore2, giocatore3: @team.giocatore3, giocatore4: @team.giocatore4)
      flash[:notice] = "Esiste già un team con gli stessi giocatori!"
      redirect_to new_team_path
      return
    end

    if(Team.exists?(nome_team: @team.nome_team))
      flash[:notice] = "Esiste già un team con lo stesso nome"
      redirect_to new_team_path
      return
    end

    if(@team.giocatore2 != "")
      giocatore2 = User.find_by(uid: @team.giocatore2)
      if giocatore2 == nil
        BattlenetOauthService.ottieniProfilo(session[:access_token], @team.giocatore2)
        if(Stat.find_by(uid: @team.giocatore2) == nil)
          flash[:notice] = "Il giocatore con id #{@team.giocatore2} non ha un account nel gioco, inserire un altro id"
          redirect_to new_team_path
          return
        end
      end
    end

    if(@team.giocatore3 != "")
      giocatore3 = User.find_by(uid: @team.giocatore3)
      if giocatore3 == nil
        BattlenetOauthService.ottieniProfilo(session[:access_token], @team.giocatore3)
        if(Stat.find_by(uid: @team.giocatore3) == nil)
          flash[:notice] = "Il giocatore con id #{@team.giocatore3} non ha un account nel gioco, inserire un altro id"
          redirect_to new_team_path
          return
        end
      end
    end

    if(@team.giocatore4 != "")
      giocatore4 = User.find_by(uid: @team.giocatore4)
      if giocatore4 == nil
        BattlenetOauthService.ottieniProfilo(session[:access_token], @team.giocatore4)
        if(Stat.find_by(uid: @team.giocatore4) == nil)
          flash[:notice] = "Il giocatore con id #{@team.giocatore4} non ha un account nel gioco, inserire un altro id"
          redirect_to new_team_path
          return
        end
      end
    end

    respond_to do |format|
      if @team.save
        calculate_averages(@team)
        format.html { redirect_to team_url(@team), notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }

        from = User.find_by(uid: @team.giocatore1)
        if giocatore2 != nil
          send_notification(from, giocatore2, "#{@team.giocatore1} ti ha invitato al team #{@team.nome_team}")
        end
          
        if giocatore3 != nil
          send_notification(from, giocatore3, "#{@team.giocatore1} ti ha invitato al team #{@team.nome_team}")
        end
          
        if giocatore4 != nil
          send_notification(from, giocatore4, "#{@team.giocatore1} ti ha invitato al team #{@team.nome_team}")
        end

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def calculate_averages(team)
    player_ids = [team.giocatore1, team.giocatore2, team.giocatore3, team.giocatore4]
    players_stats = Stat.where(uid: player_ids)
    
    averages = {}
    averages[:terranwins] = players_stats.average(:terranwins)
    averages[:protosswins] = players_stats.average(:protosswins)
    averages[:zergwins] = players_stats.average(:zergwins)
    averages[:careertotalgames] = players_stats.average(:careertotalgames)
    averages[:totalwins] = players_stats.average(:totalwins)
    averages[:totallosses] = players_stats.average(:totallosses)
    averages[:wlratio] = players_stats.average(:wlratio)
    averages[:level] = players_stats.average(:level)
    averages[:levelterran] = players_stats.average(:levelterran)
    averages[:totallevelxpterran] = players_stats.average(:totallevelxpterran)
    averages[:currentlevelxpterran] = players_stats.average(:currentlevelxpterran)
    averages[:levelzerg] = players_stats.average(:levelzerg)
    averages[:totallevelxpzerg] = players_stats.average(:totallevelxpzerg)
    averages[:currentlevelxpzerg] = players_stats.average(:currentlevelxpzerg)
    averages[:levelprotoss] = players_stats.average(:levelprotoss)
    averages[:totallevelxpprotoss] = players_stats.average(:totallevelxpprotoss)
    averages[:currentlevelxpprotoss] = players_stats.average(:currentlevelxpprotoss)
    averages[:wins1vs1] = players_stats.average(:wins1vs1)
    averages[:games1vs1] = players_stats.average(:games1vs1)
    averages[:wins2vs2] = players_stats.average(:wins2vs2)
    averages[:games2vs2] = players_stats.average(:games2vs2)
    averages[:wins3vs3] = players_stats.average(:wins3vs3)
    averages[:games3vs3] = players_stats.average(:games3vs3)
    averages[:wins4vs4] = players_stats.average(:wins4vs4)
    averages[:games4vs4] = players_stats.average(:games4vs4)
    averages[:winsarchon] = players_stats.average(:winsarchon)
    averages[:gamesarchon] = players_stats.average(:gamesarchon)
    averages[:totalpointsachievements] = players_stats.average(:totalpointsachievements)
    averages[:seasontotalgames] = players_stats.average(:seasontotalgames)
    averages[:totalgamesthisseason] = players_stats.average(:totalwinsthisseason)
  
    team_stat = TeamStat.new(averages.merge(team: team))
    team_stat.save
  end  

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    giocatori = [team_params[:giocatore1]]
    if team_params[:giocatore2] != ""
      giocatori.append(team_params[:giocatore2])
    end

    if team_params[:giocatore3] != ""
      giocatori.append(team_params[:giocatore3])
    end

    if team_params[:giocatore4] != ""
      giocatori.append(team_params[:giocatore4])
    end

    if(giocatori.length != giocatori.uniq.length)
      flash[:notice] = "Non puoi mettere due volte lo stesso id"
      redirect_to edit_team_path
      return
    end

    if(giocatori.length < 2)
      flash[:notice] = "Un team deve essere composto da almeno due giocatori!"
      redirect_to edit_team_path
    end

    # Removing the first element from the array
    giocatori.shift

    # Now "giocatori" only holds each "giocatore" that is not "" and not the team leader.
    # I need to check who's gone to send them a message
    byebye = []
    welcome = []
    oldname = @team.nome_team

    if giocatori[0] != @team.giocatore2
      byebye.append(giocatori[0])
      welcome.append(@team.giocatore2)
    end

    if giocatori.length > 1 && giocatori[1] != @team.giocatore3
      byebye.append(giocatori[1])
      welcome.append(@team.giocatore3)
    end

    if giocatori.length > 2 && giocatori[2] != @team.giocatore4
      byebye.append(giocatori[2])
      welcome.append(@team.giocatore4)
    end
    
    giocatori.sort!
    while giocatori.length < 3
      giocatori.append("")
    end

    teamparams = {"nome_team" => team_params[:nome_team], "giocatore1" => team_params[:giocatore1], "giocatore2" => giocatori[0], "giocatore3" => giocatori[1], "giocatore4" => giocatori[2]}

    @team1 = Team.new(teamparams)

    if Team.exists?(giocatore1: @team1.giocatore1, giocatore2: @team1.giocatore2, giocatore3: @team1.giocatore3, giocatore4: @team1.giocatore4)
      flash[:notice] = "Esiste già un team con gli stessi giocatori!"
      redirect_to edit_team_path
      return
    end

    if(Team.exists?(nome_team: @team1.nome_team) && @team1.nome_team != @team.nome_team)
      flash[:notice] = "Esiste già un team con lo stesso nome"
      redirect_to edit_team_path
      return
    end

    giocatori.append(@team.giocatore1)

    if(@team1.giocatore2!="")
      BattlenetOauthService.ottieniProfilo(session[:access_token], @team1.giocatore2)
      if(Stat.find_by(uid: @team1.giocatore2) == nil)
        flash[:notice] = "Il giocatore con id #{@team1.giocatore2} non ha un account nel gioco, inserire un altro id"
        redirect_to edit_team_path
        return
      end
    end

    if(@team1.giocatore3!="")
      BattlenetOauthService.ottieniProfilo(session[:access_token], @team1.giocatore3)
      if(Stat.find_by(uid: @team1.giocatore3) == nil)
        flash[:notice] = "Il giocatore con id #{@team1.giocatore3} non ha un account nel gioco, inserire un altro id"
        redirect_to edit_team_path
        return
      end
    end

    if(@team1.giocatore4!="")
      BattlenetOauthService.ottieniProfilo(session[:access_token], @team1.giocatore4)
      if(Stat.find_by(uid: @team1.giocatore4) == nil)
        flash[:notice] = "Il giocatore con id #{@team1.giocatore4} non ha un account nel gioco, inserire un altro id"
        redirect_to edit_team_path
        return
      end
    end
    
    respond_to do |format|
      if @team.update(teamparams)
        calculate_averages_update(@team)
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }

        from = User.find_by(uid: @team1.giocatore1)
        for user in byebye do
          user = User.find_by(uid: user)
          if user != nil
            send_notification(from, user, "Il team leader #{from.nickname} ti ha rimosso dal team #{oldname}")
          end
        end

        for user in welcome do
          user = User.find_by(uid: user)
          if user != nil
            send_notification(from, user, "Il team leader #{from.nickname} ti ha aggiunto nel team #{@team.nome_team}")
          end
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def calculate_averages_update(team)
    player_ids = [team.giocatore1, team.giocatore2, team.giocatore3, team.giocatore4]
    players_stats = Stat.where(uid: player_ids)
    
    averages = {}
    averages[:terranwins] = players_stats.average(:terranwins)
    averages[:protosswins] = players_stats.average(:protosswins)
    averages[:zergwins] = players_stats.average(:zergwins)
    averages[:careertotalgames] = players_stats.average(:careertotalgames)
    averages[:totalwins] = players_stats.average(:totalwins)
    averages[:totallosses] = players_stats.average(:totallosses)
    averages[:wlratio] = players_stats.average(:wlratio)
    averages[:level] = players_stats.average(:level)
    averages[:levelterran] = players_stats.average(:levelterran)
    averages[:totallevelxpterran] = players_stats.average(:totallevelxpterran)
    averages[:currentlevelxpterran] = players_stats.average(:currentlevelxpterran)
    averages[:levelzerg] = players_stats.average(:levelzerg)
    averages[:totallevelxpzerg] = players_stats.average(:totallevelxpzerg)
    averages[:currentlevelxpzerg] = players_stats.average(:currentlevelxpzerg)
    averages[:levelprotoss] = players_stats.average(:levelprotoss)
    averages[:totallevelxpprotoss] = players_stats.average(:totallevelxpprotoss)
    averages[:currentlevelxpprotoss] = players_stats.average(:currentlevelxpprotoss)
    averages[:wins1vs1] = players_stats.average(:wins1vs1)
    averages[:games1vs1] = players_stats.average(:games1vs1)
    averages[:wins2vs2] = players_stats.average(:wins2vs2)
    averages[:games2vs2] = players_stats.average(:games2vs2)
    averages[:wins3vs3] = players_stats.average(:wins3vs3)
    averages[:games3vs3] = players_stats.average(:games3vs3)
    averages[:wins4vs4] = players_stats.average(:wins4vs4)
    averages[:games4vs4] = players_stats.average(:games4vs4)
    averages[:winsarchon] = players_stats.average(:winsarchon)
    averages[:gamesarchon] = players_stats.average(:gamesarchon)
    averages[:totalpointsachievements] = players_stats.average(:totalpointsachievements)
    averages[:seasontotalgames] = players_stats.average(:seasontotalgames)
    averages[:totalgamesthisseason] = players_stats.average(:totalwinsthisseason)
  
    team_stat = TeamStat.find_by(team: team)
    team_stat.update(averages)
  end

  # abbandona
  def abbandona
    if @team.giocatore2 != team_params[:giocatore2]
      uscente = @team.giocatore2
    elsif @team.giocatore3 != team_params[:giocatore3]
      uscente = @team.giocatore3
    elsif @team.giocatore4 != team_params[:giocatore4]
      uscente = @team.giocatore4
    end

    respond_to do |format|
      if @team.update(team_params)

        # Notification in case everything works out
        to_user = User.find_by(uid: @team.giocatore1)
        from_user = User.find_by(uid: uscente)

        send_notification(from_user, to_user, "L'utente #{from_user.nickname} ha abbandonato il team #{@team.nome_team}.")

        if @team.giocatore2 == "" && @team.giocatore3 == "" && @team.giocatore4 == ""
          notification = Notification.new
          notification.from = Admin.first.id
          notification.to = to_user.id
          notification.touser = true
          notification.body = "Il team #{@team.nome_team} non ha piu' giocatori e per questo e' stato eliminato."
          notification.save
      
          to_user.bell = true
          to_user.save

          @team.destroy
        end

        format.html { redirect_to personstats_url, notice: "Team was successfully abandoned." }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    # Notification in case everything works out
    from_user = User.find_by(uid: @team.giocatore1)
    body = "L'utente #{from_user.nickname} ha eliminato il team #{@team.nome_team} di cui facevi parte."

    if @team.giocatore2 != ""
      to_user = User.find_by(uid: @team.giocatore2)
      if to_user != nil
        send_notification(from_user, to_user, body)
      end
    end

    if @team.giocatore3 != ""
      to_user = User.find_by(uid: @team.giocatore3)
      if to_user != nil
        send_notification(from_user, to_user, body)
      end
    end

    if @team.giocatore4 != ""
      to_user = User.find_by(uid: @team.giocatore4)
      if to_user != nil
        send_notification(from_user, to_user, body)
      end
    end

    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def worst_teams
    closest_values = TeamStat.order("wlratio").limit(3)
    teams_data = closest_values.map do |team_stat|
      { name: team_stat.team.nome_team, wlRatio: team_stat.wlratio }
    end
    render json: teams_data
  end

  def best_teams
    furthest_values = TeamStat.order("wlratio DESC").limit(3)
    teams_data = furthest_values.map do |team_stat|
      { name: team_stat.team.nome_team, wlRatio: team_stat.wlratio }
    end
    render json: teams_data
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:nome_team, :giocatore1, :giocatore2, :giocatore3, :giocatore4)
    end

    def send_notification(from, to, body)
      notification = Notification.create!(from: from.id, to: to.id, body: body, fromuser: true, touser: true, isinvitation: true)

      to.bell = true
      to.save
    end
end
