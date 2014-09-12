class UsersController < ApplicationController
	def index
		render json: User.all.map {&:name}
	end

	def create
		@user = User.create(user_params)
		redirect_to @user
	end

	def user_params
		params.require(:user).permit(:fname, :lname, :email)
	end

	def show
		@user = User.find(params[:id])
	end
end
