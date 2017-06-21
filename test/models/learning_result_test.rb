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

require 'test_helper'

class LearningResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
