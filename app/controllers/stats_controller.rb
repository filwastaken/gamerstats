class StatsController < ApplicationController
  before_action :set_stat, only: %i[ show edit update destroy ]

  # GET /stats or /stats.json
  def index
    redirect_to root_path
    @stats = Stat.all
  end

  # GET /stats/1 or /stats/1.json
  def show
    redirect_to root_path
  end

  # GET /stats/new
  def new
    redirect_to root_path
    @stat = Stat.new
  end

  # GET /stats/1/edit
  def edit
    redirect_to root_path
  end

  # POST /stats or /stats.json
  def create
    redirect_to root_path
    @stat = Stat.new(stat_params)

    respond_to do |format|
      if @stat.save
        format.html { redirect_to stat_url(@stat), notice: "Stat was successfully created." }
        format.json { render :show, status: :created, location: @stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stats/1 or /stats/1.json
  def update
    redirect_to root_path
    respond_to do |format|
      if @stat.update(stat_params)
        format.html { redirect_to stat_url(@stat), notice: "Stat was successfully updated." }
        format.json { render :show, status: :ok, location: @stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats/1 or /stats/1.json
  def destroy
    redirect_to root_path
    @stat.destroy

    respond_to do |format|
      format.html { redirect_to stats_url, notice: "Stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat
      redirect_to root_path
      @stat = Stat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stat_params
      redirect_to root_path
      params.require(:stat).permit(:uid, :region, :realm, :displayName, :terranWins, :protossWins, :zergWins, :careerTotalGames, :totalWins, :totalLosses, :wlRatio, :level, :levelTerran, :totalLevelXPTerran, :currentLevelXPTerran, :levelZerg, :totalLevelXPZerg, :currentLevelXPZerg, :levelProtoss, :totalLevelXPProtoss, :currentLevelXPProtoss, :wins1vs1, :games1vs1, :wins2vs2, :games2vs2, :wins3vs3, :games3vs3, :wins4vs4, :games4vs4, :winsArchon, :gamesArchon, :totalPointsAchievements, :highest1v1Rank, :highestTeamRank, :clanName, :clanTag, :profilePath, :primaryRace, :seasonId, :seasonNumber, :seasonYear, :seasonTotalGames, :totalWinsThisSeason, :totalLossesThisSeason, :wlRatioThisSeason)
    end
end
