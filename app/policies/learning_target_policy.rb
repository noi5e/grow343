class LearningTargetPolicy < ApplicationPolicy

  def show?
    true
  end

  def index?
    true
  end

  def results?
    teacher?
  end

  def edit_results?
    teacher?
  end

  def update_results?
    teacher?
  end

  class Scope < Scope

    def initialize(user, scope)
      @user = user
      case user
      when Student
        @scope = scope.where(id: user.learning_target_ids)
      else
        @scope = scope
      end
    end

    def resolve
      scope
    end
  end
end
