# == Schema Information
#
# Table name: learning_resources
#
#  id                 :integer          not null, primary key
#  name               :string
#  url                :string
#  learning_target_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_learning_resources_on_learning_target_id  (learning_target_id)
#
# Foreign Keys
#
#  fk_rails_...  (learning_target_id => learning_targets.id)
#

class LearningResource < ApplicationRecord
  belongs_to :learning_target
end
