class CustomFieldsController < ApplicationController
  # GET /custom_fields
  # OR /clients/:id/custom_fields
  def index
    @custom_fields = CustomField.all

    if params[:client_id]
      @custom_fields = @custom_fields.where(client_id: params[:client_id])
    end

    render json: {
      status: :success,
      data: @custom_fields
    }
  end
end
