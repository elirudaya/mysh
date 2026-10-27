class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin?
        return redirect_to admin_path
      else
        return redirect_to home_path
      end
    end

    @email = Email.new
  end

  def create
    @email = Email.new(email_params)

    if @email.save
      redirect_to root_path, notice: "Благодарим за подписку!"
    else
      render :index, status: :unprocessable_content
    end
  end

  private

  def email_params
    params.require(:email).permit(:address, :consent)
  end
end
