class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def mine
    @posts = current_user.posts.order(created_at: :desc)
  end

  def show
    authorize! :read, @post
  end

  def new
    @post = Post.new
    authorize! :create, @post
  end

  def edit
    authorize! :update, @post
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.status = "approved"
    authorize! :create, @post

    if @post.save
      redirect_to @post, notice: "Пост опубликован"
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    authorize! :update, @post

    if @post.update(post_params)
      redirect_to @post, notice: "Изменения сохранены"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize! :destroy, @post
    @post.destroy!

    redirect_to current_user.admin? ? admin_posts_path : mine_posts_path,
                notice: "Пост удален",
                status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
