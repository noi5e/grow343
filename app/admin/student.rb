ActiveAdmin.register Student do

  permit_params :email, :password, :first_name, :last_name, student_detail_attributes: [:id, :teacher_id, :english_second_language, :graduation_year, :individualized_education_plan]

  config.sort_order = 'last_name_asc'

  form do |f|

    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
    end

    f.object.build_student_detail if f.object.student_detail.nil?

    f.inputs do
      f.fields_for :student_detail do |f2|
        f2.input :graduation_year
        f2.input :english_second_language, collection: StudentDetail.english_second_languages.keys
        f2.input :individualized_education_plan, collection: StudentDetail.individualized_education_plans.keys
        f2.input :teacher
      end
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :last_name
    column :first_name
    column :graduation_year, sortable: 'student_details.graduation_year'
    column :teacher
    actions
  end

  show do

    attributes_table do
      row :teacher
      resource.student_detail.attributes.keys.each do |key|
        next if key.in?(%w(id teacher_id student_id))
        row key
      end
    end

    attributes_table do
      resource.attributes.keys.each do |key|
        next if key.in?(%w(encrypted_password))
        row key
      end
    end
    active_admin_comments
  end

end
