class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can %i[update destroy], Post, user_id: user.id
      can %i[update destroy], Comment, user_id: user.id
      can :create, Post if user.has_role? :author

      cannot :create, Tag
      cannot :create, Category
    end
  end
end
