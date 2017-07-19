class AddNotesToLearningResults < ActiveRecord::Migration[5.1]
  def change
    add_column :learning_results, :notes, :text
  end
end
