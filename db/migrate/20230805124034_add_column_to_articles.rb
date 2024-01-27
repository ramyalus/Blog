class AddColumnToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :approved_by, :integer, :default => nil
    add_column :articles, :published_at, :datetime, :default => nil
  end
end
