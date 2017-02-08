Rails.application.routes.draw do
  resources :messages, except: [:edit, :update, :show, :destroy, :index]
  get 'messages/:id' => redirect("/")
  get 'messages' => redirect("/")
  get 'sessions/new'
  get 'static_pages/help'
  root 'static_pages#home'
  get 'generic'  => 'static_pages#simple'
  get 'signup' => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'logout'  => 'sessions#destroy'
  get 'needirb' => 'static_pages#irbassesment'

  resources :users
  resources :irbs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
