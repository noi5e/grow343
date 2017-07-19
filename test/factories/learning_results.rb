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

FactoryGirl.define do
  factory :learning_result do
    student nil
    learning_target nil
    score 1.5
  end
end
