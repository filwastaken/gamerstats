class TeamStatsController < ApplicationController
  before_action :set_team_stat, only: %i[ show edit update destroy ]

  # GET /team_stats or /team_stats.json
  def index
    redirect_to root_path
    @team_stats = TeamStat.all
  end

  # GET /team_stats/1 or /team_stats/1.json
  def show
    redirect_to root_path
  end

  # GET /team_stats/new
  def new
    redirect_to root_path
    @team_stat = TeamStat.new
  end

  # GET /team_stats/1/edit
  def edit
    redirect_to root_path
  end

  # POST /team_stats or /team_stats.json
  def create
    redirect_to root_path
    @team_stat = TeamStat.new(team_stat_params)

    respond_to do |format|
      if @team_stat.save
        format.html { redirect_to team_stat_url(@team_stat), notice: "Team stat was successfully created." }
        format.json { render :show, status: :created, location: @team_stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_stats/1 or /team_stats/1.json
  def update
    redirect_to root_path
    respond_to do |format|
      if @team_stat.update(team_stat_params)
        format.html { redirect_to team_stat_url(@team_stat), notice: "Team stat was successfully updated." }
        format.json { render :show, status: :ok, location: @team_stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_stats/1 or /team_stats/1.json
  def destroy
    redirect_to root_path
    @team_stat.destroy

    respond_to do |format|
      format.html { redirect_to team_stats_url, notice: "Team stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_stat
      redirect_to root_path
      @team_stat = TeamStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_stat_params
      redirect_to root_path
      params.require(:team_stat).permit(:team_id, :uid, :terranwins, :protosswins, :zergwins, :careertotalgames, :totalwins, :totallosses, :wlratio, :level, :levelterran, :totallevelxpterran, :currentlevelxpterran, :levelzerg, :totallevelxpzerg, :currentlevelxpzerg, :levelprotoss, :totallevelxpprotoss, :currentlevelxpprotoss, :wins1vs1, :games1vs1, :wins2vs2, :games2vs2, :wins3vs3, :games3vs3, :wins4vs4, :games4vs4, :winsarchon, :gamesarchon, :totalpointsachievements, :seasontotalgames, :totalgamesthisseason)
    end
end
