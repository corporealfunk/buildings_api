class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show ]

  # GET /clients
  def index
    @clients = Client.all

    render json: {
      status: :success,
      data: @clients
    }
  end

  # GET /clients/1
  def show
    render json: {
      status: :success,
      data: @client
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:name)
    end
end
