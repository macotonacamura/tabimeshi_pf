Rails.application.routes.draw do

  root :to => 'users/homes#top'
  post '/users/homes/guest_sign_in', to: 'users/homes#new_guest'

	# devise_for :admins, controllers: {
	# sessions:      'admins/sessions',
	# passwords:     'admins/passwords',
	# registrations: 'admins/registrations'
	# }

	devise_for :admins, skip: :all #これに上のdevise_forを消して、書き換える
    devise_scope :admin do
	    get '/admins/sign_in' => 'admins/sessions#new'
	    post '/admins/sign_in' => 'admins/sessions#create'
	    delete '/admins/sign_out' => 'admins/sessions#destroy'
    end

    namespace :admins do
		get 'admins/top' => 'top#top'
		resources :users,only:[:index, :show, :edit, :update]
		resources :genres, only: [:edit, :index, :create, :update]
		resources :reviews

    end



	devise_for :users, controllers: {
	sessions:      'users/sessions',
	passwords:     'users/passwords',
	registrations: 'users/registrations',
	omniauth_callbacks: 'users/omniauth_callbacks'
	}




	scope module: :users do
		resources :users,only:[:index, :show, :edit, :update,]
		get '/users/:id/unsubscribe' => 'users#unsubscribe',as: 'users_unsubscribe'
		patch '/users/:id/withdraw' => 'users#withdraw',as: 'users_withdraw'
		get 'users/:id/following',to: 'users#following' ,as: 'relationship_following'
		get 'users/:id/follower',to: 'users#follower' ,as: 'relationship_follower'
		get 'users/:id/likes',to: 'users#likes', as:'likes_list'


		resources :reviews do
			resource :likes, only:[:create, :destroy]
			resources :review_comments, only:[:create, :destroy]
			collection do
      			get 'search'
      		end
      		collection do
      			get 'reviews/auto_complete' #
    		end
		end


		resources :relationships, only: [:create, :destroy]
		get 'countries/asia' => 'countries#asia'
		get 'countries/america' => 'countries#america'
		get 'countries/europe' => 'countries#europe'
		get 'countries/oseania' => 'countries#oseania'


	end

end
