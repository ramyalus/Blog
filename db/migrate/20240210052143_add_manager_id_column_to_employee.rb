class AddManagerIdColumnToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :manager_id, :integer
  end
end
