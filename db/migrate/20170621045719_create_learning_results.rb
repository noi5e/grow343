class CreateLearningResults < ActiveRecord::Migration[5.1]
  def change
    create_table :learning_results do |t|
      t.belongs_to :student, null: false
      t.belongs_to :learning_target, foreign_key: true, null: false
      t.float :score

      t.timestamps
    end
    add_foreign_key :learning_results, :users, column: :student_id
  end
end
