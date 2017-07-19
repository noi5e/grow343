# == Schema Information
#
# Table name: learning_resources
#
#  id                    :integer          not null, primary key
#  name                  :string
#  url                   :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  learning_objective_id :integer          not null
#  category              :integer          default("instruction"), not null
#
# Indexes
#
#  index_learning_resources_on_learning_objective_id  (learning_objective_id)
#
# Foreign Keys
#
#  fk_rails_...  (learning_objective_id => learning_objectives.id)
#

class LearningResource < ApplicationRecord

  enum category: %i(instruction practice)

  belongs_to :learning_objective

  validates :learning_objective, :category, presence: true
end
