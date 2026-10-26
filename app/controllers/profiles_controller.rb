class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [ :edit, :update ]
  before_action :set_profile, only: [ :show, :edit, :update ]


  def show
    authorize! :read, @profile

    if user_signed_in? && current_user == @profile.user
      @posts = @profile.user.posts.order(created_at: :desc)
    else
      @posts = @profile.user.posts.approved.order(created_at: :desc)
    end
  end


  def edit
    authorize! :update, @profile
  end

  def update
    authorize! :update, @profile

    if @profile.update(profile_params)
      redirect_to @profile, notice: "Профиль обновлён."
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end


  def profile_params
    params.require(:profile).permit(
      :name,
      :age,
      :origin_country,
      :origin_city,
      :current_country,
      :current_city,
      :social
    )
  end
end
