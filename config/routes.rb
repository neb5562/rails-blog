Rails.application.routes.draw do
  root "posts#index"
  
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope "/:locale", locale: /en|ka|ua/ do
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      sessions: 'users/sessions'
    }

    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")

    get "/user/:username/posts", to: "posts#user_posts", as: :user_posts
    get "/posts/new", to: "posts#new_post", as: :create_new_post
    get "/post/:id/edit", to: "posts#edit_post", as: :edit_post
    patch "/post/:id", to: "posts#save_edit_post", as: :save_edit_post
    get "/:username/post/:id", to: "posts#post", as: :show_post
    put "/posts/save", to: "posts#save_new_post", as: :save_new_post
    get "/post/:id/toggle_status", to: "posts#toggle_post_status", as: :toggle_post_status
    get "/profile/posts", to: "posts#user_posts_list", as: :user_posts_list
    get "/profile/settings", to: "users#settings", as: :user_settings
    get "/profile/settings/avatar", to: "users#avatar", as: :avatar
    get "/profile/settings/appearance", to: "users#appearance", as: :appearance
    post "/profile/appearance", to: "users#save_appearance", as: :save_appearance
    post "/profile/avatar", to: "users#save_avatar", as: :save_user_avatar
    get "/profile/settings/addresses", to: "addresses#address", as: :address
    get "/profile/settings/addresses/new", to: "addresses#new_address", as: :new_address
    post "/profile/addresses/new", to: "addresses#new_address", as: :find_address
    put "/profile/addresses/new", to: "addresses#new", as: :save_address    
    put "/post/:id/add_comment", to: "comments#save", as: :save_new_comment
    patch "/post/:id/comments/:comment_id/update", to: "comments#update", as: :save_edit_comment
    get "/user/activity", to: "users#activity", as: :user_profile_activity
    delete "/posts/:id/delete", to: "posts#delete_user_post", as: :delete_user_post
    get "/profile/settings/phones/new", to: "phones#new", as: :new_phone
    put "/profile/phones/new", to: "phones#save_new_phone", as: :save_phone   
    get "/profile/settings/phones", to: "phones#index", as: :phone
    delete "/profile/phone/:phone/delete", to: "phones#delete", as: :delete_phone

    get "/profile/settings/privacy", to: "users#privacy", as: :privacy
    get "/categories/new", to: "categories#new", as: :new_category
    put "/categories/new", to: "categories#create", as: :save_new_category
    get "/profile/categories", to: "categories#index", as: :user_post_actegories
    get "/category/:name", to: "categories#category_posts", as: :show_category_posts
    match '/search',  to: 'posts#search_posts', via: 'get', as: :search

    match '/auth/:provider/callback', :to => 'omniauth#google_oauth2', :via => [:get, :post]
  end
  
  get '*all', to: 'application#error_page', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
  post "/likes/save", to: "likes#save", as: :save_like
  # get '*unmatched_route', to: 'application#error_page'

end


