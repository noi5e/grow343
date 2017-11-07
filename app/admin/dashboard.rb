ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    if current_user.is_a?(Student)
      render 'student_dashboard'
    elsif current_user.is_a?(Teacher)
    end

  end # content
end
