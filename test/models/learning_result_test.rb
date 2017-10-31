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

require 'test_helper'

class LearningResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
