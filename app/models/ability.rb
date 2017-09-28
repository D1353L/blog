class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Article unless user

    if user
      if user.has_role? :admin
        can :manage, :all
      elsif user.has_role? :copyriter
        can :manage, Article
      end
    end
  end
end
