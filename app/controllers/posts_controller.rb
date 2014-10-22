class PostsController < ApplicationController
	def index
		#@posts = Post.all
	end

  include SessionsHelper
	def show
		@post = Post.includes([:comments => :user]).find(params[:id])
		@comment = Comment.new
    curr_user = current_user
    @user_name = curr_user.name
    @post_id = @post.id
	end

	def new
		@post = Post.new
	end

	def create
		x = post_params.update({user_id: current_user.id})
		@post = Post.create(x)
		redirect_to @post

	end

	def post_params
		params.require(:post).permit(:title, :body)
	end

	def test
	end

	def edit
		@post = Post.find(params[:id])

	end

	def update
		@post = Post.find(params[:id])
		respond_to do |format|
			if @post.update(post_params)
				format.html {redirect_to @post, notice: 'Post was successfully updated.'}
				format.json {head :no_content}
			else
				format.html {render action: 'edit'}
				format.json {render json: @post.errors, status: :unprocessable_entity}
			end
		end
	end

	def append_feed
		@posts = Post.where("id = ? AND created_at < ?", params[:user_id], params[:time].to_time).limit(20).offset(params[:current_length].to_i)
		render partial: 'posts/index'
	end

	def append_comments
			comments = Comment.where("post_id = ? AND created_at < ?", params[:post_id], params[:time])[params[:current_length],20]
			render json: (comments.nil? ? [] : comments)
	end

	def append_index
		@posts = Post.where("created_at < ?", params[:time].to_time).limit(20).offset(params[:current_length].to_i)
		render partial: 'posts/index'
	end

	def comments
		@comments = Comment.where(post_id: params[:id])
		respond_to do |format|
			format.json { render json: @comments.to_a }
		end
	end
end
