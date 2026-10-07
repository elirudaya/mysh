class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /friendships or /friendships.json
  def index
    @friendships = Friendship.all
  end

  # GET /friendships/1 or /friendships/1.json
  def show
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships or /friendships.json
  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.user = current_user
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: "Friendship was successfully created." }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @friendship.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /friendships/1 or /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: "Friendship was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @friendship.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    @friendship.destroy!

    respond_to do |format|
      format.html { redirect_to friendships_path, notice: "Friendship was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.expect(friendship: [ :friend_email, :status ])
    end
end
