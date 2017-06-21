class CreateLearningResources < ActiveRecord::Migration[5.1]
  def change
    create_table :learning_resources do |t|
      t.string :name
      t.string :url
      t.belongs_to :learning_target, foreign_key: true, null: false

      t.timestamps
    end
  end
end
