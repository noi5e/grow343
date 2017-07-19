class AddCategoryToLearningResources < ActiveRecord::Migration[5.1]
  def change
    add_column :learning_resources, :category, :integer, null: false, default: 0
  end
end
