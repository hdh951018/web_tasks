Rails.application.routes.draw do

  controller :sessions do
    get    'login'  => :new
    post   'login'  => :create
    delete 'logout' => :destroy
  end
  get 'admins/:id/password'     =>'admins#edit_password'
  get 'admins/:id/profile'     =>'admins#edit_profile'
  get 'admin/posts/:id/show'    =>'admin/posts#show_admin'
  get 'admin/index'             =>'admins#welcome'
  get 'admin/comments/check'    =>'admin/comments#checked'
  get 'admin/comments/uncheck'  =>'admin/comments#unchecked'
  post'admin/comments/check'    =>'admin/comments#check_switch'
  post'admin/comments/uncheck'  =>'admin/comments#check_switch'
  # get 'index'                   =>'posts'
  resources :admins, :except => [:index]  #禁止访问主页管理员列表
  namespace :admin do
    resources :posts do
      resources :comments
    end
    resources :feedbacks,:except => [:new,:edit,:update,:create] 
    resources :comments, :except => [:show] 
  end

  resources :posts,:except =>[:new,:create,:edit,:update,:destroy] do
    resources :comments,:except =>[:destroy,:update,:index,:edit]
  end
  resources :feedbacks,:only => [:new,:create]
  # resources :comments #禁止直接访问
  # resources :posts

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
