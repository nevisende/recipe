class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    return unless user.present?

    can :manage, :all, user_id: user.id
    return unless user.role == 'admin'

    can :manage, :all
  end
end
