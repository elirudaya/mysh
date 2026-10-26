# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Post, status: "approved"
    can :read, Profile
    can :read, Place
    can :read, Trip
    can :read, Event
    can :read, Checklist

    return unless user.persisted?

    can :create, Post
    can [ :read, :update, :destroy ], Post,
        user_id: user.id
    can :create, Comment
    can [ :update, :destroy ], Comment, user_id: user.id

    can :update, Profile, user_id: user.id

    if user.admin?
      can :read, Post
      can [ :approve, :reject ], Post

      can :destroy, Comment

      can :manage, Place
      can :manage, Trip
      can :manage, Event
      can :manage, Checklist
    end
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
