class ArticleJob < ApplicationJob
  queue_as :default

  def perform(user_id, category_id)
  	user = User.find user_id
		filename = "#{user.name}_articles_#{Time.now}.csv"
		folder_path = Rails.root.join('public','export_articles')
		file_path = "#{folder_path}/#{filename}"
		articles = user.articles.where(category_id: category_id)
		if articles.present?
			CSV.open(file_path, 'w') do |csv|
				puts "Exporting articles"
				csv << articles.first.attributes.keys
				articles.each do |article|
					csv << article.attributes.values
				end
			end
			message = "exported successfully"
		else
			message = "No artilcles found to export"
		end
		send_export_mail(message)
  end

  def send_export_mail(message)
  	puts "Message #{message}"
  end
end
