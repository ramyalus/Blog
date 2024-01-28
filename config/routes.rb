Rails.application.routes.draw do
  require 'resque/server'
  mount Resque::Server, at: '/jobs'
  devise_for :users
	root to: "articles#index"


	devise_scope :user do  
   	get '/users/sign_out' => 'devise/sessions#destroy'     
	end
  
  # post '/articles/approve/:id' => 'articles#approve_article'
  # post '/articles/approve' => 'articles#approve_article'


	resources :categories
	resources :articles do 
    member do
  		put 'approve' => 'articles#approve_article'
      put 'publish' => 'articles#publish'
    end
    collection do 
      get 'ajax_search' => 'articles#ajax_search'
    	get 'to_publish' => 'articles#publishable'
      put 'bulk_approve_article' => 'articles#bulk_approve_article'
      put 'bulk_publish_article' => 'articles#bulk_publish_article'
      match 'export_csv' => 'articles#export', :as => 'export_csv', :via => [:get, :post]
    end
	end
end
