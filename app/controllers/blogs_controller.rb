class BlogsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :user_blogs, :show, :search_blogs]

  PER_PAGE = 9


  def index
    @blogs = Blog.where(active: true).order('created_at desc').includes(:comments, :user).page(params['page']).per(PER_PAGE)
    render 'blogs/index'
  end

  def user_blogs
    # @blogs = Blog.where(active: true).order('comments.created_at desc').page(params['page']).per(PER_PAGE).includes(comments: :user).find_by(user_id: params[:user_id])
    begin
      @user = User.find_by(username: params["username"])
      @blogs = Blog.where(user_id: @user.id, active: true).order('created_at desc').includes(:comments, :user).page(params['page']).per(PER_PAGE)
      render 'blogs/index'
    rescue
      error_page
    end
  end

  def search_blogs 
    # begin
      @blogs = Blog.search(params[:query]).order('created_at desc').includes(:comments, :user).page(params['page']).per(PER_PAGE)
      render 'blogs/index'
    # rescue
      # error_page
    # end
  end

  def new_blog 
    @blog = Blog.new
    render 'blogs/new'
  end

  def save_new_blog
    @blog = current_user.blogs.build(blog_params)
    categories = params[:categories].reject { |e| e.to_s.empty? }
    blog_categories = []
    
    ActiveRecord::Base.transaction do
      
      categories.each do |cat_item|
        blog_categories << BlogCategory.new(blog_id: @blog.id, category_id: cat_item )
      end

      @blog.blog_categories << blog_categories
      @res = @blog.save
     end

    respond_to do |format|
      if @res
        format.html { redirect_to root_path, notice: "blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def show 
    begin
      @blog = Blog.where(active: true).order('comments.created_at desc').includes(:comments => [:likes, :user]).find_by_hashid(params[:id])
      @comment = Comment.new
      @prev = @blog.prev 
      @next = @blog.next
      render 'blogs/post'
    rescue
      error_page
    end
  end

  def edit_blog 
    begin
      @blog = current_user.blogs.find_by_hashid(params[:id])
      render 'blogs/edit'
    rescue
      error_page
    end 
  end
  
  def save_edit_blog
    @blog = current_user.blogs.find_by_hashid(params[:id])
    blog_categories = []
    @blog.blog_title = params[:blog_title]
    @blog.blog_description = params[:blog_description]
    @blog.blog_text = params[:blog_text]
    @blog.active = params[:active]
    
    categories = params[:categories].reject { |e| e.to_s.empty? }
    blog_categories = []
    
    ActiveRecord::Base.transaction do
      @blog.blog_categories.destroy_all
      categories.each do |cat_item|
        blog_categories << BlogCategory.new(blog_id: @blog.id, category_id: cat_item )
      end

      @blog.blog_categories << blog_categories
      @res = @blog.save
     end



    respond_to do |format|
      if @blog.save
        format.html { redirect_to edit_blog_path(@blog.hashid), notice: "blog was successfully Edited." }
        format.json { render :'blogs/edit', status: :created, location: @blog }
      else
        format.html { render :'blogs/edit', status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_blogs_list 
    @blogs = current_user.blogs.order('created_at desc').page(params['page']).per(PER_PAGE)
    render 'blogs/blogs_list'
  end

  def toggle_blog_status 
    begin
      @blog = current_user.blogs.find_by_hashid(params[:id])
      @blog.active = !@blog.active
      @blog.save
      flash[:notice] = 'Successfully updatet status!'
      redirect_to user_blogs_list_path
    rescue
      error_page
    end 
  end

  def delete_user_blog
    begin
      blog = current_user.blogs.find_by_hashid(params[:id])
      blog.destroy
      flash[:notice] = 'Successfully deleted blog!'
      redirect_to user_blogs_list_path
    rescue
      error_page
    end 
  end
  

  private 

  def blog_params
    params.permit(:blog_title, :blog_text, :blog_description, :active)
  end

end
