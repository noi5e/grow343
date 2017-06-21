class CreateLearningTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :learning_targets do |t|
      t.integer :grade
      t.integer :version
      t.string :title
      t.text :common_core_state_standards

      t.timestamps
    end
  end
end
