class UserInterestsController < ApplicationController
  before_action :set_user_interest, only: %i[ show edit update destroy ]

  # GET /user_interests or /user_interests.json
  def index
    @user_interests = UserInterest.all
  end

  # GET /user_interests/1 or /user_interests/1.json
  def show
  end

  # GET /user_interests/new
  def new
    @user_interest = UserInterest.new
  end

  # GET /user_interests/1/edit
  def edit
  end

  # POST /user_interests or /user_interests.json
  def create
    @user_interest = UserInterest.new(user_interest_params)

    respond_to do |format|
      if @user_interest.save
        format.html { redirect_to @user_interest, notice: "User interest was successfully created." }
        format.json { render :show, status: :created, location: @user_interest }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @user_interest.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /user_interests/1 or /user_interests/1.json
  def update
    respond_to do |format|
      if @user_interest.update(user_interest_params)
        format.html { redirect_to @user_interest, notice: "User interest was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user_interest }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @user_interest.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /user_interests/1 or /user_interests/1.json
  def destroy
    @user_interest.destroy!

    respond_to do |format|
      format.html { redirect_to user_interests_path, notice: "User interest was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_interest
      @user_interest = UserInterest.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_interest_params
      params.expect(user_interest: [ :user_id, :interest_id ])
    end
end
