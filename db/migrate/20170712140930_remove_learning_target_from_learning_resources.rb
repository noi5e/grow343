class RemoveLearningTargetFromLearningResources < ActiveRecord::Migration[5.1]
  def change
    remove_reference :learning_resources, :learning_target, foreign_key: true
  end
end
