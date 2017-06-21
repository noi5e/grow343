class AddTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :type, :string
    add_index :users, [:id, :type], unique: true
  end
end
