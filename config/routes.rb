Mysite::Application.routes.draw do

  root  "home#welcome"
  get '/home',:to=> 'home#home'
  get '/my_work',:to=> 'work_intro#index'
  get '/my_blog',:to=> 'blogs#index'
  get '/my_interest',:to=> 'interest#index'
  get '/my_book',:to=> 'my_book#index'
  get '/my_book/book_list',:to=> 'my_book#get_books'
  get '/my_book/find_book/:name',:to=> 'my_book#find_book'

  post '/my_blog/add_comment',:to=> 'blogs#add_comment'
  get '/my_blog/get_comment/:id',:to=> 'blogs#get_comment'
  get '/my_blog/find_by_offset/:offset',:to=> 'blogs#find_by_offset'
  get '/gallery',:to=> 'gallery#album'
  get '/album/:id',:to=> 'gallery#show'
  get '/album/:id/upload',:to=> 'gallery#create'
  get '/album/:id/:offset',:to=> 'gallery#get_more_photo'
  get '/gallery/get_pic',:to=> 'gallery#get_pic'
  get '/gallery/new',:to=> 'gallery#new'
  post '/gallery/new',:to=> 'gallery#new_create'
  post '/blogs/:id/like',:to=> 'blogs#like'
  post '/blogs/:id/dislike',:to=> 'blogs#dislike'

  resources :blogs
  resources :tags
  resources :books,:controller=>'my_book'
  resources :photos






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
