class PreferitosController < ApplicationController
  before_action :set_preferito, only: %i[ show edit update destroy ]

  # GET /preferitos or /preferitos.json
  def index
    @preferitos = Preferito.all
  end

  # GET /preferitos/1 or /preferitos/1.json
  def show
  end

  # GET /preferitos/new
  def new
    @preferito = Preferito.new
  end

  # GET /preferitos/1/edit
  def edit
  end

  # POST /preferitos or /preferitos.json
  def create
    @preferito = Preferito.new(preferito_params)

    respond_to do |format|
      if @preferito.save
        format.html { redirect_to preferito_url(@preferito), notice: "Preferito was successfully created." }
        format.json { render :show, status: :created, location: @preferito }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @preferito.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferitos/1 or /preferitos/1.json
  def update
    respond_to do |format|
      if @preferito.update(preferito_params)
        format.html { redirect_to preferito_url(@preferito), notice: "Preferito was successfully updated." }
        format.json { render :show, status: :ok, location: @preferito }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @preferito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferitos/1 or /preferitos/1.json
  def destroy
    @preferito.destroy

    respond_to do |format|
      format.html { redirect_to preferitos_url, notice: "Preferito was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preferito
      @preferito = Preferito.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def preferito_params
      params.require(:preferito).permit(:mitt_id, :nome_dest, :dest_id)
    end
end
