class WelcomeController < ApplicationController
  def index
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
