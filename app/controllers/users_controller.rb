class UsersController < ApplicationController
	def new
		@user = User.new
	end	

	def index
		@user_names = User.all.map(&:name)
	end

	def create
		@user = User.create(user_params)
		s = Session.new(user_id: @user.id)
    s.save_with_session_code
    cookies.permanent[:session_code] = s.session_code
		redirect_to @user
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end

	def show
		@user = User.find(params[:id])
	end

	def edit 
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		respond_to do |format|
			if @user.update(user_params)
				format.html {redirect_to @user, notice: 'User was successfully updated.'}
				format.json {head :no_content}
			else
				format.html {render action: 'edit'}
				format.json {render json: @user.errors, status: :unprocessable_entity}
			end
		end
	end

	def append_feed
		render json: Post.where("user_id = ? AND created_at < ?", current_user.id, params[:time])[params[:current_length], 20]
		render json: (posts.nil? ? [] : posts)
	end			
end
