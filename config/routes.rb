Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "blogs#index"

  get "/user/:username/blogs", to: "blogs#user_blogs", as: :user_blogs
  get "/blogs/new", to: "blogs#new_blog", as: :create_new_blog
  get "/blog/:id/edit", to: "blogs#edit_blog", as: :edit_blog
  put "/blog/:id/edit", to: "blogs#save_edit_blog", as: :save_edit_blog
  get "/blog/:id", to: "blogs#show", as: :show_blog
  put "/blogs/save", to: "blogs#save_new_blog", as: :save_new_blog
  get "/blog/:id/toggle_status", to: "blogs#toggle_blog_status", as: :toggle_blog_status
  get "/profile/blogs", to: "blogs#user_blogs_list", as: :user_blogs_list

  put "/blog/:id/add_comment", to: "comments#save", as: :save_new_comment

  delete "/blogs/:id/delete", to: "blogs#delete_user_blog", as: :delete_user_blog
  post "/likes/save", to: "likes#save", as: :save_like

  get "/categories/new", to: "categories#new", as: :new_category
  put "/categories/new", to: "categories#create", as: :save_new_category
  get "/profile/categories", to: "categories#index", as: :user_blog_actegories
  get "/category/:name", to: "categories#category_blogs", as: :show_category_blogs
  
  get '*unmatched_route', to: 'application#error_page'
end


