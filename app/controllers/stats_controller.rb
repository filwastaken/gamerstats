class StatsController < ApplicationController
  before_action :set_stat, only: %i[ show edit update destroy ]

  # GET /stats or /stats.json
  def index
    #Stat.delete_all #DA ELIMINARE
    @stats = Stat.all
  end

  # GET /stats/1 or /stats/1.json
  def show
  end

  # GET /stats/new
  def new
    @stat = Stat.new
  end

  # GET /stats/1/edit
  def edit
  end

  # POST /stats or /stats.json
  def create
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
    @stat.destroy

    respond_to do |format|
      format.html { redirect_to stats_url, notice: "Stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat
      @stat = Stat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stat_params
      params.require(:stat).permit(:id, :number, :preferredSlot, :givenName, :name, :familyName, :role, :headshotUrl, :eroe, :abilityDamageDone, :accretionKills, :amplificationMatrixAssists, :barrageKills, :bioticGrenadeKills, :blizzardKills, :bobKills, :carnageKills, :chainHooksAttempted, :chargedShotKills, :coalescenseHealing, :concussionMineKills, :criticalHits, :damageAmplified, :damageBlockedSojurn, :damageDiscordOrb, :damageTaken, :deadeyeKills, :deathBlossomKills, :deaths, :dragonbladeKills, :dragonstrikeKills, :earthshatterKills, :earthshatterStuns, :eliminations, :enemiesChainHooked, :enemiesEMPd, :enemiesFrozen, :enemiesHacked, :enemiesSlept, :energyMax, :finalBlows, :focusingBeamKills, :graviticFluxKills, :gravitonSurgeKills, :healingDone, :helixRocketKills, :heroDamageDone, :immortalityFieldDeathsPrevented, :inspireUptime, :jaggedBladeKills, :javelinDamage, :jumpPackKills, :kitsuneRushAssists, :knockbackKills, :kunaiKills, :lifetimeEnergyAccumulation, :meteorStrikeKills, :moltenCoreKills, :negativeEffectsCleansed, :overclockKills, :overhealthProvided, :piledriverKills, :playersKnockedBack, :playersResurrected, :playersTeleported, :primalRageKills, :pulseBombKills, :pulseBombsAttached, :ripTireKills, :rocketDirectHits, :scopedCriticalHitKills, :scopedCriticalHits, :scopedHits, :selfdestructKills, :shotsHit, :soloKills, :stickyBombsKills, :stormArrowKills, :tacticalVisorKills, :terraSurgeKills, :timePlayed, :timeSpentOnFire, :turretKills, :ultimatesNegated, :ultsEarned, :ultsUsed, :wholeHogKills)
    end
end
