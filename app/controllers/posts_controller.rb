class PostsController < ApplicationController
	def index
		@posts = Post.all
	end
	def test
	end
end
