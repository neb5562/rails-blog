class CategoriesController < ApplicationController
  before_action :authenticate_user!, :except => [:category_blogs]

  PER_PAGE = 9

  def category_blogs
    begin
      @blogs = Category.find_by(name: params["name"].titleize.downcase).blogs.order('created_at desc').page(params['page']).per(PER_PAGE)
      render 'blogs/index'
    rescue
      error_page
   end
  end

  def index 
    @categories = Category.order('created_at desc').page(params['page']).per(PER_PAGE)
    render 'categories/index'
  end

  def new
    @category = Category.new
  end

  def create 
    @category = Category.new(category_params)
    
    respond_to do |format|
      if @category.save
        format.html { redirect_to new_category_path, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

  def category_params
    params.permit(:name)
  end
end
