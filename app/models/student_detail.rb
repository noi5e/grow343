# == Schema Information
#
# Table name: student_details
#
#  id                            :integer          not null, primary key
#  student_id                    :integer          not null
#  teacher_id                    :integer          not null
#  english_second_language       :integer
#  individualized_education_plan :integer
#  graduation_year               :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
# Indexes
#
#  index_student_details_on_student_id  (student_id)
#  index_student_details_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => users.id)
#  fk_rails_...  (teacher_id => users.id)
#

class StudentDetail < ApplicationRecord
  belongs_to :student
  belongs_to :teacher

  enum({
    english_second_language: %i(yes_esl no_esl former_esl),
    individualized_education_plan: %i(yes_iep no_iep declassified_iep)
  })

  validates :teacher, presence: true
end
