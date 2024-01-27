class Category < ApplicationRecord
	validates_presence_of :title, :description
	validates_uniqueness_of :title
  
  has_many :articles
	self.per_page = 20
end
