ActiveAdmin.register LearningResult do

  belongs_to :learning_target


  action_item :results, only: %i(show) do
    link_to 'Results', [:results, :admin, resource.learning_target]
  end

  permit_params :student_id, :notes, :score, :version, learning_objective_ids: []

  form do |f|
    h2 { f.object.student.name } if f.object.persisted?
    f.inputs do
      f.input :student, collection: Student.all if f.object.new_record?
      f.input :version
      f.input :score
      f.input :learning_objectives, as: :check_boxes, collection: f.object.learning_target.learning_objectives
      f.input :notes
    end
    f.actions
  end

end
