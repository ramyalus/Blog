module ArticlesConcern
	def search_article
    search = params[:search]
    if current_user.is_admin && search.present?
      @articles = Article.includes(:user, :category).where("approved_by IS NULL && published_at IS NULL && title LIKE ?", "%#{search}%")
    elsif current_user.is_admin 
      @articles = Article.includes(:user, :category).where("approved_by IS NULL && published_at IS NULL")
    elsif !current_user.is_admin && search.present?
      @articles = current_user.articles.includes(:user, :category).where("approved_by IS NOT NULL  && published_at IS NOT NULL && title LIKE ?", "%#{search}%")
    else
      @articles = current_user.articles.includes(:user, :category).where("approved_by IS NOT NULL  && published_at IS NOT NULL")
    end
    @articles = @articles.paginate(:page => params[:page]).order('id DESC')
  end
end