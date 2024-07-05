Rails.application.routes.draw do
  devise_for :users
  # 追記
  root to: 'homes#top'
  # 記述変更
      get '/home/about', to: 'homes#about'
      # get '/books', to: 'books#index', as: 'books'
      # get 'users/:id', to: 'users#show', as: 'user'
      # get 'books/:id', to: 'books#show', as: 'book'
      # get 'users', to: 'users#index'
      # get 'homes/about', to: 'homes#about', as: 'about'
      get '/users/:id/edit', to: 'users#edit', as: 'edit_user'

      get "search" => "searches#search"#検索機能

       resources :books  do
        resource :favorites, only: [:create, :destroy]
        resources :book_comments, only: [:create, :destroy]
        member do
          get :edit, to: 'books#edit' # booksコントローラのeditアクションへのルートを追加
          #delete :destroy, to: 'books#destroy' # booksコントローラのdestroyアクションへのルートを追加
           end
           collection do
            delete :destroy, to: 'books#destroy'
          end
       end

       resources :users, only: [:index, :show, :create, :update]do
          patch '/:id', to: 'users#update', as: 'update_user'
          resource :relationships, only: [:create, :destroy]
       end
end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


