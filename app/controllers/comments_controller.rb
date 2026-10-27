class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def create
    authorize! :read, @post
    authorize! :create, Comment

    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Комментарий добавлен"
    else
      redirect_to @post, alert: "Напиши текст для комментария"
    end
  end

  def edit
    authorize! :update, @comment
    authorize! :read, @post
  end

  def update
    authorize! :update, @comment
    authorize! :read, @post

    if @comment.update(comment_params)
      redirect_to @post, notice: "Комментарий изменен"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize! :destroy, @comment
    authorize! :read, @post

    @comment.destroy!

    redirect_to @post,
                notice: "Комментарий был удален",
                status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
