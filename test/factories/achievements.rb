# == Schema Information
#
# Table name: achievements
#
#  id                    :integer          not null, primary key
#  learning_result_id    :integer          not null
#  learning_objective_id :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_achievements_on_learning_objective_id  (learning_objective_id)
#  index_achievements_on_learning_result_id     (learning_result_id)
#
# Foreign Keys
#
#  fk_rails_...  (learning_objective_id => learning_objectives.id)
#  fk_rails_...  (learning_result_id => learning_results.id)
#

FactoryGirl.define do
  factory :achievement do
    learning_result nil
    learning_objective nil
  end
end
