# == Schema Information
#
# Table name: learning_objectives
#
#  id                 :integer          not null, primary key
#  name               :string
#  learning_target_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_learning_objectives_on_learning_target_id  (learning_target_id)
#
# Foreign Keys
#
#  fk_rails_...  (learning_target_id => learning_targets.id)
#

class LearningObjective < ApplicationRecord
  belongs_to :learning_target
  has_many :learning_resources, dependent: :destroy
  has_many :achievements
  has_many :learning_results, through: :achievements

  accepts_nested_attributes_for :learning_resources, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

end
