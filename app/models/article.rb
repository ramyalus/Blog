require 'carrierwave/orm/activerecord'
include ArticleConcern

class Article < ApplicationRecord
	validates_presence_of :category_id, :title, :content
	belongs_to :category
	belongs_to :user
  
	#Followed this docs - https://code.tutsplus.com/uploading-with-rails-and-carrierwave--cms-28409a
	mount_uploader :image_url, AvatarUploader

	before_validation :assign_user_id, on: :create
	before_save :before_save_callback  # 1st
	after_save :after_save_callback  #4th
  before_create :before_create_callback # 2nd
  after_create :after_create_callback  #3rd

  before_commit :before_commit_callback #5th
  after_commit :after_commit_callback #6th

	self.per_page = 20

	private    #access specifiers public, private and protected

	def assign_user_id            # calling private method in console object.send(:method_name, var1,var2.....)
		self.user_id = User.current_user.id
		puts("user assigned")
	end

  def is_approved?
  	self.approved_by.present? 
  end










	def print_something(x, z="shivu")
		# binding.pry
		puts(z)
		puts(x)
	end

	def before_save_callback
		puts "before save callback"
	end

	def after_save_callback
		puts "after save callback"
	end

	def before_create_callback
		puts "before create callback"
	end

	def after_create_callback
		puts "after create callback"
	end

	def after_commit_callback
		puts "after commit callback" 
	end

	def before_commit_callback
		puts "before commit callback"
	end
end







