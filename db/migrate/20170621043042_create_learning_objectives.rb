class CreateLearningObjectives < ActiveRecord::Migration[5.1]
  def change
    create_table :learning_objectives do |t|
      t.string :name
      t.belongs_to :learning_target, foreign_key: true, null: false

      t.timestamps
    end
  end
end
