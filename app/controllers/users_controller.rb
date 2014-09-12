class UsersController < ApplicationController
	def index
		render json: User.all.map { |u| u.name }
	end

	def create
		@user = User.create(user_params)
		redirect_to @user
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email)
	end

	def show
		@user = User.find(params[:id])
	end
end
