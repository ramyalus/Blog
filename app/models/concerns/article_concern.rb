module ArticleConcern
	def self.included(base)
		base.extend(ClassMethods)
	end
	module ClassMethods
		def export_articles(category_id)
		  user_id = User.current_user.id
		  ArticleJob.perform_later(user_id, category_id)
		end
	end
end