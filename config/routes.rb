Rails.application.routes.draw do

	root :to => 'users/homes#top'

	devise_for :admins, controllers: {
	sessions:      'admins/sessions',
	passwords:     'admins/passwords',
	registrations: 'admins/registrations'
	}
	devise_for :users, controllers: {
	sessions:      'users/sessions',
	passwords:     'users/passwords',
	registrations: 'users/registrations'
	}

	namespace :admins do
		resources :genres
		resources :users
	end

	scope module: :users do
	resources :users,only:[:index, :show, :edit, :update,]
	get '/users/unsubscribe' => 'users#unsubscribe'
	patch '/users/withdraw' => 'users#withdraw'

	resources :reviews

	end

end
