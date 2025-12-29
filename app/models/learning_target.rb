# == Schema Information
#
# Table name: learning_targets
#
#  id                          :integer          not null, primary key
#  grade                       :integer
#  title                       :string
#  common_core_state_standards :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

class LearningTarget < ApplicationRecord

  has_many :learning_results, dependent: :destroy
  has_many :learning_objectives, dependent: :destroy
  has_many :learning_resources, through: :learning_objectives

  def students
    @students ||= Student.grade(grade)
  end

  accepts_nested_attributes_for :learning_resources, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :learning_objectives, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :learning_results, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

  validates :title, presence: true
  validates :grade, numericality: {greater_than_or_equal_to: 6, less_than_or_equal_to: 8}

end
