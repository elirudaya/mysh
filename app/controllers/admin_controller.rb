class AdminController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :check_admin

  def index
    @users_count = User.count
    @posts_count = Post.count
    @emails_count = Email.count

    @posts = Post.order(created_at: :desc).limit(5)
    @users = User.order(created_at: :desc).limit(5)
  end

  def users
    @users = User.order(created_at: :desc)
  end

  def posts
    @posts = Post.order(created_at: :desc)
  end

  def emails
    @emails = Email.order(created_at: :desc)
  end

  private

  def check_admin
    unless current_user.admin?
      redirect_to home_path,
                  alert: "Доступ только для администратора."
    end
  end
end
