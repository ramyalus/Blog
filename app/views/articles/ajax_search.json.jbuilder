#constructing the response for json as per our requirement.
json.articles do
	json.array! @articles do |article|
		json.id article.id
		json.title article.title
		json.content article.content
		json.user_name article.user.name
		json.category_title article.category.title
	end
end