class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
		@post = Post.includes([:comments => :user]).find(params[:id])
		@comment = Comment.new
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.create(post_params)
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
end
