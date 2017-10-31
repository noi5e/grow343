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
#  version            :integer          not null
#  notes              :text
#
# Indexes
#
#  index_learning_results_on_learning_target_id     (learning_target_id)
#  index_learning_results_on_student_id             (student_id)
#  index_results_on_student_and_target_and_version  (student_id,learning_target_id,version) UNIQUE
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

  validates :score, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 4, step: 0.25}, presence: true
  validates :version, {
    numericality: {greater_than_or_equal_to: 1, step: 1},
    presence: true,
    uniqueness: {scope: [:learning_target_id, :student_id]}
  }

  def achieved?(objective)
    objective.id.in?(learning_objective_ids)
  end

  def score_group
    @score_group ||= if score == 4
      4
    elsif score >= 3
      3
    elsif score >= 2
      2
    else
      1
    end
  end

end
