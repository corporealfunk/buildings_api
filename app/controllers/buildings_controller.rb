class BuildingsController < ApplicationController
  before_action :set_building, only: %i[ show update destroy ]

  # GET /buildings
  def index
    page = (params[:page] || 1).to_i
    limit = (params[:limit] || 0).to_i

    # sanity check
    page = 1 if page < 1

    # if limit is invalid, default to no pagination:
    if limit < 1
      limit = 0
      page = 1
    end


    total_records = Building.count
    if total_records == 0
      render json: {
        status: 'success',
        data: [],
        pagination: {
          total_records: 0,
          current_page: nil,
          total_pages: 0,
          next_page: nil,
          prev_page: nil,
          limit: limit
        }
      } and return
    end

    # we have records, calculate:
    limit = total_records if limit == 0

    total_pages = (total_records / limit.to_f).ceil

    render json: {
      status: 'success',
      data: Building.joins(:client).includes(:client).order(:id)
        .offset((page - 1) * limit)
        .limit(limit),
      pagination: {
        total_records: total_records,
        current_page: page,
        total_pages: total_pages,
        next_page: page < total_pages ? page + 1 : nil,
        prev_page: page > 1 ? page - 1 : nil,
        limit: limit
      }
    }
  end

  # GET /buildings/1
  def show
    render json: @building
  end

  # POST /buildings
  def create
    @building = Building.new(building_params)

    if @building.save
      render json: @building, status: :created, location: @building
    else
      render json: @building.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /buildings/1
  def update
    if @building.update(building_params)
      render json: @building
    else
      render json: @building.errors, status: :unprocessable_entity
    end
  end

  # DELETE /buildings/1
  def destroy
    @building.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building
      @building = Building.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def building_params
      params.require(:building).permit(:client_id, :address_1, :address_2, :city, :state, :zip, :custom_fields)
    end
end
