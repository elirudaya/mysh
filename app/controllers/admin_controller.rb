class AdminController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :check_admin

  def index
    @users_count = User.count
    @pending_posts_count = Post.pending.count
    @places_count = Place.count
    @events_count = Event.count
    @guides_count = Checklist.count

    @posts = Post.order(created_at: :desc).limit(5)
    @users = User.order(created_at: :desc).limit(5)
  end

  def users
    @users = User.order(created_at: :desc)
  end

  def posts
    @posts = Post.pending.order(created_at: :desc)
  end

  def events
  end

  def guides
  end

  def places
  end

  private

  def check_admin
    unless current_user.admin?
      redirect_to home_path,
                  alert: "Доступ только для администратора."
    end
  end
end
