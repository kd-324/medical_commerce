class SkusController < ApplicationController
  before_action :validate_create, only: :create
  before_action :validate_update, only: :update
  before_action :validate_id, only: [:update, :show, :destroy]

  def create
    sku = Sku.create(sku_params)
    if sku
      render json: sku, status: :created
    else
      render json: { errors: sku.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    sku = Sku.find_by(id: params[:id])
    if sku
      render json: sku
    else
      render json: { error: 'Sku not found' }, status: :not_found
    end
  end

  def update
    sku = Sku.find_by(id: params[:id])
    if sku&.update(sku_params)
      render json: sku
    else
      render json: { errors: sku.errors.full_messages || 'Sku not found' }, status: :unprocessable_entity
    end
  end

  def destroy
    sku = Sku.find_by(id: params[:id])
    if sku&.destroy
      render json: { message: 'Sku deleted successfully' }, status: :ok
    else
      render json: { error: 'Sku not found' }, status: :not_found
    end
  end

  private

  def validate_create
    param! :name, String, required: true
    param! :description, String, required: true
    param! :price, Float, required: true
    param! :is_otc, :boolean, required: true
  end

  def validate_update
    param! :name, String
    param! :description, String
    param! :price, Float
    param! :is_otc, :boolean
  end

  def validate_id
    param! :id, Integer, required: true
  end

  def sku_params
    params.permit(:name, :description, :price, :quantity, :is_otc)
  end
end
