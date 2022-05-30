class BlogsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :user_blogs, :show]

  PER_PAGE = 5


  def index
    @blogs = Blog.where(active: true).order('created_at desc').page(params['page']).per(PER_PAGE)
    render 'blogs/index'
  end

  def user_blogs
    @blogs = Blog.where(user_id: params[:user_id], active: true).order('created_at desc').page(params['page']).per(PER_PAGE)

    if @user = User.find_by_id(params["user_id"])
      render 'blogs/index'
    else
      error_page
    end
  end

  def new_blog 
    @blog = Blog.new
    render 'blogs/new'
  end

  def save_new_blog
    @blog = current_user.blogs.build(blog_params)
    
    respond_to do |format|
      if @blog.save
        format.html { redirect_to root_path, notice: "blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def show 
    if @blog = Blog.includes(comments: :user).where(id: params[:id], active: true).order('comments.created_at desc').take
      @comment = Comment.new
      render 'blogs/post'
    else
      error_page
    end

  end

  def edit_blog 
    begin
      @blog = current_user.blogs.find_by_id(params[:id])
      render 'blogs/edit'
    rescue
      error_page
    end 
  end
  
  def save_edit_blog
    @blog = current_user.blogs.build(blog_params)
    
    respond_to do |format|
      if @blog.save
        format.html { redirect_to edit_blog_path(@blog.id), notice: "blog was successfully Edited." }
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
      @blog = current_user.blogs.find_by_id(params[:id])
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
      @blog = current_user.blogs.find_by_id(params[:id])
      @blog.destroy
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
