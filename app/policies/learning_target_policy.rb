class LearningTargetPolicy < ApplicationPolicy

  def results?
    teacher?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
