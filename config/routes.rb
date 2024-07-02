Rails.application.routes.draw do
  devise_for :users
  # 追記
  root to: 'homes#top'
  # 記述変更
      get '/home/about', to: 'homes#about'
       get '/books', to: 'books#index', as: 'books'
       get 'users/:id', to: 'users#show', as: 'user'
       get 'books/:id', to: 'books#show', as: 'book'
       get 'users', to: 'users#index'

      # get 'homes/about', to: 'homes#about', as: 'about'
       get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
       #resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
       resources :books do
        resource :favorites, only: [:create, :destroy]
       end

       resources :users, only: [:index, :show, :create, :update]do
          patch '/:id', to: 'users#update', as: 'update_user'
       end
      delete 'books/:id' ,to: 'book#show', as: 'destroy_book'


end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


