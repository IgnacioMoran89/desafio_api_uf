class Api::V1::UfsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
http_basic_authenticate_with name: "juan" , password: "1234" , except:
:index

  def by_date #llama por fecha según el desafío (para el endpoint)
      @client = Client.find_by(name:request.headers["X-CLIENTE"])
      @client.consult += 1 #mi atributo consult va aumentando en uno
      @client.save #lo guarda en mi instancia
      @uf = Uf.find_by(date: params[:date]) #buscar por fecha dentro de los parámetros que están en la ruta
      render json: @uf

  end
  
  # GET /ufs
  def index
    @ufs = Uf.all

    render json: @ufs
  end

  # GET /ufs/1
  def show
    render json: @uf
  end

  # POST /ufs
  def create
    @uf = Uf.new(uf_params)

    if @uf.save
      render json: @uf, status: :created, location: @uf
    else
      render json: @uf.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ufs/1
  def update
    if @uf.update(uf_params)
      render json: @uf
    else
      render json: @uf.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ufs/1
  def destroy
    @uf.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uf
      @uf = Uf.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def uf_params
      params.require(:uf).permit(:value, :date)
    end
end
