class AddVersionToLearningResults < ActiveRecord::Migration[5.1]
  def change
    add_column :learning_results, :version, :integer
    LearningResult.update_all(version: 1)
    change_column :learning_results, :version, :integer, null: false
  end
end
