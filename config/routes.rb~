Rails.application.routes.draw do
  resources :comments

	root 'posts#index'
	resources :posts
	resources :users
	resources :sessions
	get '/login' => 'sessions#new'

match '/append_feed', to: 'users#append_feed', via:'get'
end
