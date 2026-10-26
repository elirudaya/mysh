class PostsController < ApplicationController
  before_action :authenticate_user!,
                except: [ :index, :show ]

  before_action :set_post,
                only: [ :show, :edit, :update, :destroy,
                        :approve, :reject ]

  def index
    @posts = Post.approved.order(created_at: :desc)
  end

  def mine
    @posts = current_user.posts.order(created_at: :desc)
  end

  def review
    unless current_user.admin?
      raise CanCan::AccessDenied
    end

    @posts = Post.pending.order(created_at: :desc)
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
    authorize! :create, @post

    @post.status = "pending"

    if @post.save
      redirect_to @post,
                  notice: "Пост отправлен на проверку."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    authorize! :update, @post

    @post.assign_attributes(post_params)
    @post.status = "pending"

    if @post.save
      redirect_to @post,
                  notice: "Изменения отправлены на проверку."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize! :destroy, @post

    @post.destroy!
    redirect_to mine_posts_path,
                notice: "Пост удалён.",
                status: :see_other
  end

  def approve
    authorize! :approve, @post

    @post.update!(status: "approved")
    redirect_to review_posts_path,
                notice: "Пост одобрен.",
                status: :see_other
  end

  def reject
    authorize! :reject, @post

    @post.update!(status: "rejected")
    redirect_to review_posts_path,
                notice: "Пост отклонён.",
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
