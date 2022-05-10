# frozen_string_literal: true

class BookPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    return @user && (@user.has_role? :admin)
  end

  def new?
    create?
  end

  def update?
    return @user && (@user.has_any_role? :admin, :editor)
  end

  def edit?
    update?
  end

  def destroy?
    create?
  end

  def edit_or_destroy?
    return @user && (edit? || destroy?)
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
