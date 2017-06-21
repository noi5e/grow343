ActiveAdmin.register Teacher do

  permit_params :email, :password

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :email
    actions
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
