class UsersController < ApplicationController
  include RailsParam::Param

  def create
    param! :name, :string, required: true
    param! :type, :string, required: true, in: %w[admin customer]
    param! :email, :string, required: true, format: /^[^@\s]+@[^@\s]+$/
    param! :phonenumber, :string, required: true, format: /^\d{10}$/

    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    param! :id, :integer, required: true

    user = User.find_by(id: params[:id])
    if user
      render json: user
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user&.update(user_params)
      render json: user
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

  def user_params
    params.permit(:name, :type, :email, :phonenumber)
  end
end
