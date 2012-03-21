TodoList::Application.routes.draw do

  devise_for :users

  get "pages/home"
  get "pages/contact"
  get "pages/about"

  resources :projects, except: [:show] do
    resources :lists,  except: [:show]
    member do
      get 'members'
      get 'invite'
      post 'invite_the_user'
    end
  end

  delete '/projects/:id/members/:member_id' => 'projects#remove_member', as: "remove_member_from_project"

  resources :lists, except: [:show] do
    resources :tasks, except: [:show] do
      member do
         get 'change_state'
      end
    end
  end

  resources :sessions, only: [:create]
  match '/lists/:list_id/tasks/:state' => 'tasks#index', state: /(done|in_work)/

  root :to => 'pages#home'



  # match '/lists/:list_id/tasks/:id', :to => "tasks#destroy"
  #  match '/lists/:list_id/tasks/:id/invite', :to => "tasks#create"
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
  # just remember to delete public/members.html.
  # root :to => 'welcome#members'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
