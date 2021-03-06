Findbball::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :members
  resources :courts
  resources :events
  resources :reviews,  only: [:create, :edit, :destroy]
  resources :court_photos, only: [:create, :destroy]
  resources :court_videos, only: [:create, :destroy]
  resources :pickup_games
  resources :attendees, only: [:create, :destroy]
  resources :member_actions, only: [:create, :destroy]
  resources :pickup_attendees
  resources :contacts, only: [:new, :create]
  resources :video_articles
  resources :identities  

  root 'static_pages#home'
  match '/home', to: 'static_pages#home',     via: 'get'
  match '/search_members', to: 'members#search', via: 'get'
  match '/search_courts', to: 'courts#search', via: 'get'
  match '/find-hoops', to: 'courts#find_hoops', via: 'get'
  match '/find-events', to: 'events#find_events', via: 'get'
  match '/verify_email', to: 'members#verify_email', via: 'get'

  match '/courts/:court_id/pickup_games', to: 'pickup_games#court_pickup_games', via: 'get'
  match '/courts/:court_id/reload_edit_form', to: 'courts#reload_edit_form', via: 'get'
  match '/courts/:court_id/reload_pickup_games', to: 'courts#reload_pickup_games', via: 'get'

  match '/members/:member_id/reload_pickup_games', to: 'members#reload_pickup_games', via: 'get'

  match '/admin/log', to: 'member_actions#log', via: 'get'
  match '/admin/videoArticles', to: 'video_articles#video_articles',   via: 'get'

  match '/profile', to: 'members#profile', via: 'get'
  
  #root to: "sessions#new"  
  match '/signup', to: 'identities#new',         via: 'get'
  match "/auth/:provider/callback", to: "sessions#create", via: ['get', 'post']
  match '/signout', to: 'sessions#destroy',   via: 'delete'
  match "/auth/failure", to: "sessions#failure", via: ['get', 'post']
  



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
