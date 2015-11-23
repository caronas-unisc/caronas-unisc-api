Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Users
      resources :users, except: [:update, :destroy] do
        collection do
          patch 'update'
        end
      end

      # Sessions
      resources :sessions, only: [:create, :destroy] do
        collection do
          get 'info'
        end
      end

      # Password resets
      resources :password_resets, only: [:create]

      # Matches
      get 'rides/matches' => 'rides#matches'

      resources :rides, only: [:create, :update] do
        resources :messages, only: [:index, :create]
      end

      post 'rides' => 'rides#create'
      patch 'rides/:id' => 'rides#update'

      # Ride availabilities
      ride_availabilities_constraints = { date: /\d{4}-\d{2}-\d{2}/, period: '(morning|afternoon|night)' }
      
      get 'ride_availabilities/week/:date' => 'ride_availabilities#show_for_week',
        constraints: ride_availabilities_constraints
      
      patch 'ride_availabilities/week/repeat' => 'ride_availabilities#repeat_last_week'

      put 'ride_availabilities/:date/:period' => 'ride_availabilities#update',
        constraints: ride_availabilities_constraints

      delete 'ride_availabilities/:date/:period' => 'ride_availabilities#destroy',
        constraints: ride_availabilities_constraints
    end
  end

  namespace :web do
    get '/forgot/:token' => 'password_resets#reset_form', as: 'password_reset_form'
    patch '/forgot/:token' => 'password_resets#reset_password'
  end

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
