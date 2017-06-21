ActiveAdmin.register LearningTarget do

  index do
    selectable_column
    id_column
    column :title
    column :grade
    column :version
    column :results do |item|
      item.learning_results.count
    end
    column :created_at
    column :updated_at
    actions do |resource|
      link_to '+ Result', [:new, :admin, resource, :learning_result]
    end
  end

  show do

    tabs do
      tab 'Details' do
        attributes_table do
          resource.class.column_names.each do |key|
            row key
          end
        end
        panel 'Objectives' do
          attributes_table_for resource.learning_objectives do
            row :name
          end
        end
        panel 'Resources' do
          attributes_table_for resource.learning_resources do
            row :name do |item|
              link_to item.name, item.url, target: :_blank
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

  permit_params :title, :grade, :common_core_state_standards, :version,
    learning_resources_attributes: [:name, :url, :id, :_destroy],
    learning_objectives_attributes: [:name, :id, :_destroy]

  form do |f|
    f.inputs do
      f.input :title
      f.input :grade
      f.input :version
      f.input :common_core_state_standards
    end
    f.has_many :learning_resources, allow_destroy: true do |f2|
      f2.input :name
      f2.input :url
    end
    hr
    f.has_many :learning_objectives, allow_destroy: true do |f2|
      f2.input :name
    end
    f.actions
  end
end
