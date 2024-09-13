class InventoryController < ApplicationController
  before_action :validate_operation, only: :operation
  
  def operation
    sku = Sku.find(params[:sku_id])
    quantity = params[:quantity]

    if(params[:operation] == 'add')
      sku.quantity += quantity
    elsif params[:operation] == 'remove' && sku.quantity >= quantity
      sku.quantity -= quantity
    else
      rendor json: {error: 'Invalid Operation'}, status: bad_request
    end
    
    if sku.save
      render json: { message: 'Sku quantitiy updated successfully', sku: sku}, status: :ok
    else
      render json: { errors: sku.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  
  def validate_operation
    param! :sku_id, Integer, required: true
    param! :operation, String, in: %w[add remove]
  end

  def sku_params
    params.permit(:quantity)
  end
end
