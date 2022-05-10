# Rails.application.routes.draw do
#   devise_for :users
#   resources :books
#   # get 'books', to: 'books#index'
#   # # books/new has to come first, otherwise 'new' will not be acknowledged and treated as an id
#   # # 'all methods that involve params should be below static routes for the same get/post/etc'
#   # get 'books/new', to: 'books#new'
#   # get 'books/:id', to: 'books#show', as: 'book'
#   # get 'books/:id/edit', to: 'books#edit', as: 'edit_book'
#   # patch 'books/:id', to: 'books#update' 
#   # post 'books/', to: 'books#create'
#   # delete 'books/:id', to: 'books#destroy'

#   root 'books#index'
# end

Rails.application.routes.draw do
  devise_scope :user do
    # Redirects signing out users back to sign-in
    get 'users', to: 'devise/sessions#new'
  end

  devise_for :users
  get 'books', to: 'books#index'
  get 'books/new', to: 'books#new'
  get 'books/:id', to: 'books#show', as: 'book'
  get 'books/:id/edit', to: 'books#edit', as: 'edit_book'
  patch 'books/:id', to: 'books#update'
  post 'books', to: 'books#create'
  delete 'books/:id', to: 'books#destroy'

  root 'books#index'
end
