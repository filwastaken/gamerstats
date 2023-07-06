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

  def loading_image
    send_file Rails.root.join('app', 'assets', 'images', 'loadingPiccola.gif'), type: 'image/gif', disposition: 'inline'
  end

  # POST /preferitos or /preferitos.json
  def create
    @preferito = Preferito.new(preferito_params)
    
    if Preferito.exists?(nome_dest: @preferito.nome_dest, dest_id: @preferito.dest_id)
      flash[:notice] = "Esiste già questo preferito!"
      redirect_to new_preferito_path
      return
    end

    if Preferito.exists?(dest_id: @preferito.dest_id)
      flash[:notice] = "Esiste già questo preferito!"
      redirect_to new_preferito_path
      return
    end

    if @preferito.dest_id == @preferito.mitt_id
        flash[:notice] = "Non puoi inserire te stesso tra i preferiti"
        redirect_to new_preferito_path
        return
    end

    if User.find_by(uid: @preferito.dest_id.to_i) == nil
      BattlenetOauthService.ottieniProfilo(session[:access_token], @preferito.dest_id)
      if(Stat.find_by(uid: @preferito.dest_id.to_i) == nil)
        flash[:notice] = "Il giocatore con id #{@preferito.dest_id} non ha un account nel gioco, inserire un altro id"
        redirect_to new_preferito_path
        return
      end
    end

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
    @preferito1 = Preferito.new(preferito_params)

    if Preferito.exists?(nome_dest: @preferito1.nome_dest, dest_id: @preferito1.dest_id)
      flash[:notice] = "Esiste già questo amico!"
      redirect_to edit_preferito_path
      return
    end
    
    if Preferito.exists?(dest_id: @preferito1.dest_id)
      flash[:notice] = "Esiste già questo amico!"
      redirect_to edit_preferito_path
      return
    end

    if User.find_by(uid: @preferito1.dest_id.to_i) == nil
      BattlenetOauthService.ottieniProfilo(session[:access_token], @preferito1.dest_id)
      if(Stat.find_by(uid: @preferito1.dest_id) == nil)
        flash[:notice] = "Il giocatore con id #{@preferito1.dest_id} non ha un account nel gioco, inserire un altro id"
        redirect_to edit_preferito_path
        return
      end
    end  

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
