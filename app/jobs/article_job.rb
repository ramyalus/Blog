class ArticleJob < ApplicationJob
  queue_as :default

  def perform(user_id, category_id)
  	user = User.find user_id
		filename = "#{user.name}_articles_#{Time.now}.csv"
		folder_path = Rails.root.join('public','export_articles')
		file_path = "#{folder_path}/#{filename}"
		articles = user.articles.where(category_id: category_id) rescue nil 

		CSV.open(file_path, 'w') do |csv|
			csv << articles.first.attributes.keys
			articles.each do |article|
				csv << article.attributes.values
			end
		end
  end
end
