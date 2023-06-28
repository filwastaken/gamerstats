class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]

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
    @team = Team.new(team_params)
    if( @team.giocatore2!="" || @team.giocatore3!="" || @team.giocatore4!="")
      respond_to do |format|
        if @team.save
          format.html { redirect_to team_url(@team), notice: "Team was successfully created." }
          format.json { render :show, status: :created, location: @team }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "Un team deve essere composto da almeno due giocatori!"
      redirect_to new_team_path
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    @team = Team.new(team_params)
    if( @team.giocatore2!="" || @team.giocatore3!="" || @team.giocatore4!="")
      respond_to do |format|
        if @team.update(team_params)
          format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
          format.json { render :show, status: :ok, location: @team }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "Un team deve essere composto da almeno due giocatori!"
      redirect_to edit_team_path
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
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
end
