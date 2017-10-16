ActiveAdmin.register LearningTarget do

  member_action :results do
    @q = Student.where(id: resource.learning_results.select(:student_id)).ransack(params[:q])
    @students = @q.result.includes(:learning_results)
  end

  member_action :update_results, method: :put do
    @results = params[:results].to_enum.each_with_object([]) do |item, array|
      result = resource.learning_results.find_or_initialize_by(student_id: item[0], version: params[:version])
      result.update(item[1].permit(:score, :notes, learning_objective_ids: []))
      array.push(result)
    end
    redirect_to [:admin, resource, anchor: "v#{params[:version]}"]
  end

  member_action :edit_results do
    @existing_results = resource.learning_results.where(version: params[:version])
    @students = resource.students
    @results = @students.each_with_object([]) do |student, array|
      array.push(@existing_results.detect{ |result| result.student_id == student.id } || LearningResult.new(student: student))
    end
  end

  action_item :new_result, only: :results do
    link_to 'New Result', [:new, :admin, resource, :learning_result], data: {disable_with: '...'}
  end

  action_item :results, only: :show do
    link_to "Results", [:results, :admin, resource], data: {disable_with: '...'}
  end

  sidebar :filters, partial: 'results_filter', only: :results

  index do
    selectable_column
    id_column
    column :title
    column :grade
    column :results do |item|
      item.learning_results.count
    end
    column :created_at
    column :updated_at
    actions do |resource|
      link_to 'Results', [:results, :admin, resource]
    end
  end

  show do

    tabs do
      tab 'Details' do
        columns do
          column do
            attributes_table do
              resource.class.column_names.each do |key|
                row key
              end
            end
          end
          column do
            panel 'Objectives' do
              table_for resource.learning_objectives do
                column :name
                column :instruction do |objective|
                  objective.learning_resources.instruction.each do |resource|
                    div do
                      link_to resource.name, resource.url, target: :_blank
                    end
                  end
                  nil
                end
                column :practice do |objective|
                  objective.learning_resources.practice.each do |resource|
                    div do
                      link_to resource.name, resource.url, target: :_blank
                    end
                  end
                  nil
                end
              end
            end
          end
        end
      end
      (1..3).each do |version|
        tab "V#{version}" do
          panel "V#{version} Results" do
            div do
              link_to 'Update Results', [:edit_results, :admin, resource, version: version], class: :button
            end
            table_for Student.all do
              column :name
              column :score do |student|
                student.score(resource.learning_results, version)
              end
              column :objectives do |student|
                next if student.score(resource.learning_results, version).nil?
                resource.learning_objectives.each do |objective|
                  div do
                    span do
                      student.achievements.exists?(learning_objective_id: objective.id, learning_results: {version: version}) ? '✅' : '❌'
                    end
                    span { objective.name }
                  end
                end
                nil
              end
              column :notes do |student|
                student.notes(resource.learning_results, version)
              end
            end
          end
        end
      end
      tab "Results (#{resource.learning_results.length})" do
        panel 'Results' do
          div do
            link_to 'Add Result', [:new, :admin, resource, :learning_result], class: 'button'
          end
          table_for resource.learning_results do
            column :id do |item|
              link_to item.id, [:admin, resource, item]
            end
            column :student
            column :score
            column :learning_objectives do |item|
              ids = item.achievements.pluck(:learning_objective_id).map(&:to_i)
              resource.learning_objectives.each do |objective|
                div do
                  span do
                    objective.id.in?(ids) ? '✅' : '❌'
                  end
                  span { objective.name }
                end
              end
              nil
            end
          end
        end
      end
    end
    active_admin_comments
  end

  permit_params :title, :grade, :common_core_state_standards,
    learning_objectives_attributes: [:name, :id, :_destroy, learning_resources_attributes: [:name, :url, :id, :_destroy, :category]]

  form do |f|
    f.inputs do
      f.input :title
      f.input :grade
      f.input :common_core_state_standards
    end
    hr
    f.has_many :learning_objectives, allow_destroy: true do |f2|
      f2.input :name
      f2.has_many :learning_resources, allow_destroy: true do |f3|
        f3.input :category
        f3.input :name
        f3.input :url
      end
    end
    f.actions
  end
end
