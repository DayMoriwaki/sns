Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
  devise_for :users

  resources :comments

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:"welcome#index"
  get 'posts/users/:user_id', to: 'posts#users' 
end
