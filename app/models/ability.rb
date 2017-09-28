class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Article

    if user
      can :manage, :all if user.has_role? :admin
      if user.has_role? :copyriter
        can :read, Article
        can [:read, :create, :update], Article, user_id: user.id
        can :index, :dashboard
      end
    end
  end
end
