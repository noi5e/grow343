# == Schema Information
#
# Table name: learning_results
#
#  id                 :integer          not null, primary key
#  student_id         :integer          not null
#  learning_target_id :integer          not null
#  score              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_learning_results_on_learning_target_id  (learning_target_id)
#  index_learning_results_on_student_id          (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (learning_target_id => learning_targets.id)
#  fk_rails_...  (student_id => users.id)
#

class LearningResult < ApplicationRecord
  belongs_to :student
  belongs_to :learning_target
  has_many :achievements
  has_many :learning_objectives, through: :achievements

  validates :score, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 4, step: 0.5}
end
