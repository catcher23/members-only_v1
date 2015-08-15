Rails.application.routes.draw do
  get    'signup'  => 'users#new'
  root                'sessions#new'
  post   'login'   => 'sessions#create'
  get    'login'   => 'sessions#new'
  delete 'logout'  => 'sessions#destroy'

  resources :users
end
