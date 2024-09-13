class UsersController < ApplicationController
  before_action :validate_create, only: :create
  before_action :validate_update, only: :update
  before_action :validate_id, only: [:update, :show, :destroy]

  def create
    user = User.create(user_params)
    if user
      render json: user.as_json(include: :addresses), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user.as_json(include: :addresses)
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user&.update(user_params)
      render json: user.as_json(include: :addresses)
    else
      render json: { errors: user&.errors&.full_messages || 'User not found' }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user&.destroy
      render json: { message: 'User deleted successfully' }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  private

  def validate_create
    param! :name, String, required: true
    param! :user_type, String, required: true, in: %w[admin customer]
    param! :email, String, required: true, format: /^[^@\s]+@[^@\s]+$/
    param! :phonenumber, String, required: true, format: /^\d{10}$/
  end

  def validate_update
    param! :name, String
    param! :user_type, String, in: %w[admin customer]
    param! :email, String, format: /^[^@\s]+@[^@\s]+$/
    param! :phonenumber, String, format: /^\d{10}$/
  end

  def validate_id
    param! :id, Integer, required: true
  end

  def user_params
    params.permit(:name, :user_type, :email, :phonenumber,  addresses_attributes: [:street_address, :landmark, :city, :state, :country, :pincode])
  end
end
