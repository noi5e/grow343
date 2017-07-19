class RemoveVersionFromLearningTargets < ActiveRecord::Migration[5.1]
  def change
    remove_column :learning_targets, :version, :integer
  end
end
