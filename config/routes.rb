Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :blogs do
    member do
      patch :toggle_status
    end
  end

  resources :portfolios, except: [:show] do
    member do
      patch :move
    end
  end
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'
end
