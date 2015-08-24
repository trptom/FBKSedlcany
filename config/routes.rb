FBKSedlcany::Application.routes.draw do

  get "oauths/oauth"
  get "oauths/callback"
  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  match "wiki/:section/:name" => "wikis#show"

  resources :users do
    collection do
      get :login
      get :logout
    end
    member do
      post :block
      post :unblock
      get :activate
      get :activate_manually
      get :change_password
      put :update_password
    end
  end

  resources :user_sessions do
    collection do
      get :create
      get :destroy
      get :current
    end
  end

  resources :articles do
    collection do
      get :newest
      get :best
      get :most_commented
      get :search
    end

    member do
      post :set_mark
    end
  end

  resources :article_categories do # kategorie clanku

  end

  resources :comments do # komentare k clanku
    member do
      get :react
    end
  end

  resources :players do # hraci

  end

  resources :leagues do

  end

  resources :teams do
    member do
      get :squad
      get :games
    end
    collection do
      get :new_team
      get :new_club
      get :squad
      get :games
      get :index_of_teams
      get :index_of_clubs
    end
  end

  resources :games do
    
  end

  resources :halls do

  end
  
  resources :surveys do

  end

  resources :images do
    
  end
  
  resources :wikis do
    
  end
  
  resources :events do
    
  end

  namespace :home do
    get :error
  end

  namespace :plugins do
    get :ckeditor_addplayer
    get :ckeditor_addteam
  end

  match 'about' => 'teams#about', :as => :about
  match 'squad' => 'teams#squad', :as => :squad
  match 'game_list' => 'teams#games', :as => :game_list

  match 'login' => 'user_sessions#create', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'register' => 'users#new', :as => :register
  match 'current_user' => 'users#show', :as => :current_user
  match 'home' => 'home#index', :as => :current_user

  root :to => 'home#index'

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
