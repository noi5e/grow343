class AddLearningObjectiveIdToLearningResources < ActiveRecord::Migration[5.1]
  def change
    add_reference :learning_resources, :learning_objective, foreign_key: true
    LearningResource.find_each do |resource|
      target = LearningTarget.find(resource.learning_target_id)
      resource.destroy and next if target.learning_objectives.empty?
      resource.update_column(:learning_objective_id, target.learning_objective_ids.first)
    end
    change_column :learning_resources, :learning_objective_id, :integer, null: false
  end
end
