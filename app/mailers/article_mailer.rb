class ArticleMailer < ApplicationMailer
	def article_creation
		@title = params[:title]
		mail(to: 'admin@yopmail.com', subject: 'Article creation')
	end
end
