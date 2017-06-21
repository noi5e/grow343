ActiveAdmin.register LearningResult do

  belongs_to :learning_target

  permit_params :student_id, :score, learning_objective_ids: []

  form do |f|
    h2 { f.object.student.name } if f.object.persisted?
    f.inputs do
      f.input :student, collection: Student.where.not(id: f.object.learning_target.learning_results.select(:student_id)) if f.object.new_record?
      f.input :score
      f.input :learning_objectives, as: :check_boxes, collection: f.object.learning_target.learning_objectives
    end
    f.actions
  end

end
