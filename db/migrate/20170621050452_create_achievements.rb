class CreateAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :achievements do |t|
      t.belongs_to :learning_result, foreign_key: true, null: false
      t.belongs_to :learning_objective, foreign_key: true, null: false

      t.timestamps
    end
  end
end
