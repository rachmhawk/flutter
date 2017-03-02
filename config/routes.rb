Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/destroy'

  get 'login'=> 'sessions#new', as: 'login'
  post 'login' => 'sessions#create'
  get 'logout'=> 'sessions#destroy', as:'logout'

  get 'register' => 'users#new', as: 'register'

  get 'show/new'

  get 'show/edit'

  resources :posts do
    post 'like' => 'posts#like', as: 'like'
  end

  resources :users, except:[:index]
    match '/' => 'posts#index', via: [:get, :posts], as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
