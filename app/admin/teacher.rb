ActiveAdmin.register Teacher do

  permit_params :email, :password, :first_name, :last_name

  member_action :log_in, method: :post do
    sign_in(Teacher.find(params[:id]))
    redirect_to :admin_dashboard
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
    end
    f.inputs do
      f.input :first_name
      f.input :last_name
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :email
    actions do |teacher|
      link_to 'Sign In', [:log_in, :admin, teacher], method: :post
    end
  end

  show do
    attributes_table do
      resource.attributes.keys.each do |key|
        next if key.in?(%w(encrypted_password))
        row key
      end
    end
    active_admin_comments
  end

end
