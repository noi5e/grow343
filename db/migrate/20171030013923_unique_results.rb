class UniqueResults < ActiveRecord::Migration[5.1]
  def change
    add_index :learning_results, [:student_id, :learning_target_id, :version], :name => "index_results_on_student_and_target_and_version", :unique => true
  end
end
