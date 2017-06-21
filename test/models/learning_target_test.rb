# == Schema Information
#
# Table name: learning_targets
#
#  id                          :integer          not null, primary key
#  grade                       :integer
#  version                     :integer
#  title                       :string
#  common_core_state_standards :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

require 'test_helper'

class LearningTargetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
