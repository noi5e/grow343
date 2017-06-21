class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def teacher?
    @user.is_a?(Teacher)
  end

  def index?
    teacher?
  end

  def show?
    teacher? && scope.where(:id => record.id).exists?
  end

  def create?
    teacher?
  end

  def new?
    create?
  end

  def update?
    teacher?
  end

  def edit?
    update?
  end

  def destroy?
    teacher?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
