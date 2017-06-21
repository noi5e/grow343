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

FactoryGirl.define do
  factory :learning_target do
    grade 1
    version 1
    title "MyString"
    common_core_state_standards "MyText"
  end
end
