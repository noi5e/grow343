class TeacherPolicy < ApplicationPolicy
  class Scope < Scope

    def log_in?
      teacher?
    end

    def resolve
      scope
    end
  end
end
