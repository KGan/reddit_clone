Rails.application.routes.draw do
  root to: 'subs#index'

  resources :users, except:[:edit, :update] do
    resources :subs, only: [:new]
    resources :posts, only: [:edit, :update]
  end
  resource :session, only:[:create, :new, :destroy]

  resources :subs, except: [:new] do
    resources :posts, only: [:new]
  end

  resources :posts, except: [:new, :edit, :update] do
    member do
      post 'vote' => 'votes#create', as: :vote
    end
  end

  resources :comments, only: [:create, :destroy, :update, :show] do
    member do
      post 'vote' => 'votes#create', as: :vote
    end
  end

end
