class ArticlesController < ApplicationController
	before_action :find_article, only: [:show, :edit, :update, :destroy, :approve_article, :publish]
  before_action :set_current_user
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, :only => [:approve_article, :publish, :bulk_approve_article, :bulk_publish_article, :ajax_search]
  include ArticlesConcern

  def index
    search_article
  end

  def ajax_search  
    search_article
    response = render_to_string(template: "articles/ajax_search.json.jbuilder")
    render json: response
  end

  def new   # empty dummy object for new.html.erb
  	@article = Article.new()
  end

  def create
  	@article = Article.new(article_params)
  	# @article.user_id = current_user.id   => moved to model call back 
  	if @article.save!
      ArticleMailer.with(:title => @article.title).article_creation.deliver_now
  		redirect_to articles_path
  	else
  		render action: :new
  	end
  end

  def show
    @article = current_user.articles.find(params[:id])
  end

  def edit
  end

  def update
  	if @article.update(article_params)
  		redirect_to article_path(@article)
  	else
  		redirect_to articles_path, flash: "Can't update" 
  	end
  end

  def destroy
  	if @article.destroy 
  		redirect_to articles_path, notice: "Deleted successfully"
  	else
  		redirect_to articles_path, flash: "Can't delete"
  	end
  end

  def approve_article
    is_approved = false
    if @article.present? && current_user.is_admin && !@article.approved_by.present?
      @article.approved_by = current_user.id
      # @article.published_at = DateTime.now   #TODO: publish article
      @article.save
      # @articles = current_user.articles.where("approved_by != ? && published_at != ?", nil, nil).paginate(:page => params[:page]).order('id DESC') 

      is_approved = true
      message = "Article #{@article.title}: is approved successfully!!!"
    else
      message = "Article #{params[:id]}: not found or unable to approve"
    end
    # flash[:notice] = message
    respond_to do |format|  
      format.json { render json: {message: message}}
      format.html do 
        key = is_approved ? "notice" : "alert"
        flash[key] = message
        redirect_to articles_path
      end
    end
  end

  def bulk_approve_article
    is_all_approved = false
    approve_articles = params["article_ids"]
    if current_user.is_admin
      articles = Article.where(id: params["article_ids"])
      articles.update_all(approved_by: current_user.id)
      is_all_approved = true
      message = "All selected articles got approved !!!!!...."
    else
      message = "OOPs!... sorry, You are not authorized to approve any articles..."
    end 

    key = is_all_approved ? "notice" : "alert"
    flash[key] = message
    respond_to do |format|
      format.json { render json: {message: message}}
      format.html do
        redirect_to articles_path
      end
    end
  rescue StandardError => e 
    message = "OOps!... something went wrong, please try again"
    render json: {message: message}, status: 401
  end

  def publish
    is_published = false
    begin
      if @article.send(:is_approved?)
        @article.published_at = DateTime.now
        @article.save
        is_published = true
        message = "Published successfully......."
      end
    rescue Exception => e
      message = "unable to publish...... contact admin"
      puts "#{e.message}"
    end
    
    respond_to do |format| 
      format.json { render json: {message: message, article: @article} }
      format.html do 
        key = is_published ? "notice" : "alert"
        flash[key] = message 
        redirect_to articles_path
      end
    end
  end

  def bulk_publish_article
    is_all_published = false
    articles = Article.where(id: params["publish_ids"])
    articles.update_all(published_at: DateTime.now)
    is_all_published = true
    message = "Successfully published all selected articles!!!"
    key = is_all_published ? "notice" : "alert"
    flash[key] = message 
    respond_to do |format|
      format.json {render json:{message: message}}
      format.html do 
        redirect_to to_publish_path
      end
    end
  rescue StandardError => e 
    message = "OOps! something went wrong , please try again."
    render json: {message: message}, status: 401
  end

  def publishable
    search = params[:search]
    if search.present?
      @articles = current_user.articles.includes(:user, :category).where("approved_by IS NOT NULL  && published_at IS NULL && title LIKE ?", "%#{search}%")
    else 
      @articles = current_user.articles.includes(:user, :category).where("approved_by IS NOT NULL  && published_at IS NULL")
    end
    @articles = @articles.paginate(:page => params[:page]).order("id DESC")

    respond_to do |format|
      format.json {render json: {articles: @articles}}
      format.html do
        
      end
    end
  end

  private

  def article_params
  	params.require(:article).permit(:title, :content, :user_id, :category_id, :image_url) #, {image_url: []})
  end

  def find_article
    id = params[:id].present? ? params[:id] : params[:article_id]
	  @article = Article.find id
	end

	def set_current_user
		User.current_user = current_user
	end


end
 