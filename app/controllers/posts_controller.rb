class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :user_posts, :post, :search_posts]
  @@post_sort = { 'tl' => 'comments.likes_count desc', 'tr' => 'comments.count_of_replies desc', 'lt' => 'comments.created_at desc', 'ot' => 'comments.created_at asc'}
  PER_PAGE = 9
  PER_PAGE_COMMENTS = 15

  def index
    @post = Post.new
    @posts = Post.where(active: true).order('created_at desc').includes(:comments => [:user, :likes]).page(params['page']).per(PER_PAGE)
    render 'posts/index', locals: {profile: false, posts: @posts}
  end

  def user_posts
    begin
      @user = User.find_by(username: params[:username])
      @post = Post.new
      @posts = Post.where(user_id: @user.id, active: true).order('created_at desc').includes(:comments, user: :subscriptions).page(params['page']).per(PER_PAGE)
      render 'posts/index', locals: {user: @user, profile: true}
    rescue
      error_page
    end
  end

  def search_posts 
    @post = Post.new
    @posts = Post.search(params[:query]).where(active: true).order('created_at desc').includes(:comments, :user).page(params['page']).per(PER_PAGE)
    render 'posts/index', locals: {profile: false}
  end

  def new_post 
    @post = Post.new
    render 'posts/new'
  end

  def save_new_post
    @post = current_user.posts.build(post_params)
    authorize @post
    @res = @post.save
    respond_to do |format|
      if @res
        format.html { redirect_to root_path, notice: "post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def post 
    begin
      sort = @@post_sort.key?(params[:sort]) ? @@post_sort[params[:sort]] : @@post_sort['lt']
      @post = Post.active.find_by_hashid(params[:id])
      error_page unless @post.user.username == params[:username]
      @comments = @post.comments.is_parent.page(params['page']).per(PER_PAGE_COMMENTS).order(sort)
      @comment = Comment.new
    rescue
      error_page
    end
  end

  def edit_post 
    begin
      @post = current_user.posts.find_by_hashid(params[:id])
      render 'posts/edit'
    rescue
      error_page
    end 
  end
  
  def save_edit_post
    @post = current_user.posts.find_by_hashid(params[:id])
    @post.text = params[:text]
    @res = @post.save

    respond_to do |format|
      if @post.save
        format.html { redirect_back_or_to show_post_path(@post.user.username, @post.hashid), notice: "post was succesfully Edited." }
        format.json { render :'posts/edit', status: :created, location: @post }
      else
        format.html { render :'posts/edit', status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_posts_list 
    @posts = current_user.posts.order('created_at desc').page(params['page']).per(PER_PAGE)
    render 'posts/posts_list'
  end

  def toggle_post_status 
    begin
      @post = current_user.posts.find_by_hashid(params[:id])
      @post.active = !@post.active
      @post.save
      flash[:notice] = 'Successfully updatet status!'
      redirect_to user_posts_list_path
    rescue
      error_page
    end 
  end

  def delete_user_post
    begin
      post = current_user.posts.find_by_hashid(params[:id])
      post.destroy
      flash[:notice] = 'Successfully deleted post!'
      redirect_to user_posts_list_path
    rescue
      error_page
    end 
  end
  

  private 

  def post_params
    params.permit(:text, :active)
  end

end
