class CreateStudentDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :student_details do |t|
      t.belongs_to :student, null: false
      t.belongs_to :teacher, null: false
      t.integer :english_second_language
      t.integer :individualized_education_plan
      t.integer :graduation_year

      t.timestamps
    end

    add_foreign_key :student_details , :users, column: :student_id
    add_foreign_key :student_details , :users, column: :teacher_id
  end
end
