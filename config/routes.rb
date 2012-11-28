SampleApp::Application.routes.draw do

  #get "users/new" this line was removed and replaced with resources :users

  #resources :users #this makes the URI of users to work
  
  resources :users do
    member do #member means that the routes respond to URIs containing the user id
      get :following, :followers
    end
  end  
  
  resources :sessions, only: [:new, :create, :destroy] #these are the standard RESTful actions for Sessions
  resources :microposts, only: [:create, :destroy]#these are the standard RESTful actions for Microposts
  resources :relationships, only: [:create, :destroy]#these are the standard RESTful actions for Relationships

  root to: 'static_pages#home'

  match '/help', to: 'static_pages#help'
  
  match '/about', to: 'static_pages#about'
  
  match '/contact', to: 'static_pages#contact'

  match '/signup', to: 'users#new' # when a new user is created
  match '/signin', to: 'sessions#new'# when an existing user is accessing the page
  match '/signout', to: 'sessions#destroy', via: :delete # when a user presses the sign out button
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
