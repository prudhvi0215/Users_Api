class Api::UsersController < ApplicationController
  def index
    users = User.all
    render json: {status: 'success',data: users}, status: :ok
  end

  def show
    user = User.find_by(id: params[:id])

    if user
      render json: {status: 'success',data: user}, status: :ok
    else
      render json: {status: 'error', data: "User not found!!!"}, status: :unprocessable_entity
    end
  end

  def create
    user = User.new(
      firstName: users_params[:firstName],
      lastName: users_params[:lastName],
      email: users_params[:email]
    )

    if user.save
      render json: {status: 'success', message: "Created user successfully😍", data: user}, status: :ok
    else
      render json: {status: 'error', data: "Product not created"}, status: :unprocessable_entity
    end

  end

  def update
    user = User.find_by(id: params[:id])
    if user.update(firstName: users_params[:firstName], lastName: users_params[:lastName], email: users_params[:email])
      render json: {status: 'success', message: "Updated user successfully😍", data: user}, status: :ok
    else
      render json: {status: 'error',message: "Product not created", data: user.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    render json: {status: 'success', message: "Deleted user successfully😍", data: user}, status: :ok
  end

  private

  def users_params
    params.require(:user).permit([:firstName, :lastName, :email])
  end

end
