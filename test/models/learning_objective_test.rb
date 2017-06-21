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

require 'test_helper'

class LearningObjectiveTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
