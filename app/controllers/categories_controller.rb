class CategoriesController < ApplicationController
	before_action :find_category, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

  def index
  	# @categories = Category.all
    if params[:search].present?
      # @categories = Category.where("title LIKE ?", "%" + params[:search] + "%").paginate(:page => params[:page]).order('id DESC')
      @categories = Category.includes(:articles).where("title LIKE ?", params[:search] + "%").paginate(:page => params[:page]).order('id DESC')
    else
      @categories = Category.includes(:articles).paginate(:page => params[:page]).order('id DESC')
    end

    respond_to do |format|
      format.json {render json: {categories: @categories}}
      format.html
    end
  end

  def new
		@category = Category.new  	
  end

  def create
  	@category = Category.new(category_params)
  	if @category.save
  		redirect_to categories_path, notice: "Created successfully"
  	else
  		render action: 'new'
  	end
  end

  def show
  	# @articles = Article.where(category_id: @category.id)    
    # @category = @category.includes(:articles)
    if params[:search].present?
      # @categories = Category.where("title LIKE ?", "%" + params[:search] + "%").paginate(:page => params[:page]).order('id DESC')
      @articles = @category.articles.where("user_id = ?", current_user.id).where("title LIKE ?", params[:search] + "%").paginate(:page => params[:page]).order('id DESC')
    else
       @articles = @category.articles.where("user_id = ?", current_user.id).paginate(:page => params[:page]).order('id DESC')
    end
  end

  def destroy
  	if @category.destroy
  		redirect_to categories_path, notice: "Category deleted"
  	else
  		redirect_to categories_path, flash: "Can't delete the record"
  	end
  end

  def edit
  	
  end

  def update
  	if @category.update(category_params)
  	  redirect_to category_path(@category), notice: "Category Updated"
  	else
  		redirect_to categories_path, flash: "Can't find record" 
  	end 
  end

  private

  def category_params
  	params.require(:category).permit(:title, :description)
  end

  def find_category
  	@category = Category.find params[:id]
 	end
end
