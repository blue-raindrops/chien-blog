Rails.application.routes.draw do
  resources :comments

	root 'posts#index'
	resources :posts
	resources :users
	resources :sessions
	get '/login' => 'sessions#new'
  get '/append_feed' => 'posts#append_feed'
  get '/append_index' => 'posts#append_index'
  get '/append_comments'  => 'posts#append_comments'
  get '/posts/:id/comments' => 'posts#comments'

match '/append_comments', to: 'posts#append_comments', via: 'get'
match '/append_feed', to: 'posts#append_feed', via:'get'
match '/append_feed', to: 'posts#append_index', via: 'get'
match '/append_feed', to: 'users#append_feed', via: 'get'
end
