class LearningTargetPolicy < ApplicationPolicy

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
    def resolve
      scope
    end
  end
end
