Rails.application.routes.draw do

  get 'credit_cards/destroy'

  root 'products#index'
  resources :products, only: [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :update, :destroy]
  resources :orders, only: [:edit, :update, :destroy, :create]
  resources :carts, only: [:edit, :update, :create, :destroy]
  resources :credit_cards, only: [:destroy]

  namespace :admin do
    root 'dashboard#index'
    resources :categories
    resources :products
    resources :addresses, only: [:index]
    resources :orders, only: [:index]
    resources :purchases, only: [:create, :update, :destroy]
    resources :users do
      resources :addresses
      resources :orders
    end
    resources :credit_cards, only: [:destroy]
  end

  #delete 'users/:id/cc' => 'users#destroy_credit_card'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
