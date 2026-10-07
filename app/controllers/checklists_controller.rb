class ChecklistsController < ApplicationController
  before_action :set_checklist, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]
  # GET /checklists or /checklists.json
  def index
    @checklists = Checklist.all
  end

  # GET /checklists/1 or /checklists/1.json
  def show
  end

  # GET /checklists/new
  def new
    @checklist = Checklist.new
  end

  # GET /checklists/1/edit
  def edit
  end

  # POST /checklists or /checklists.json
  def create
    @checklist = Checklist.new(checklist_params)
    @checklist.user = current_user

    respond_to do |format|
      if @checklist.save
        format.html { redirect_to @checklist, notice: "Checklist was successfully created." }
        format.json { render :show, status: :created, location: @checklist }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @checklist.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /checklists/1 or /checklists/1.json
  def update
    respond_to do |format|
      if @checklist.update(checklist_params)
        format.html { redirect_to @checklist, notice: "Checklist was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @checklist }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @checklist.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /checklists/1 or /checklists/1.json
  def destroy
    @checklist.destroy!

    respond_to do |format|
      format.html { redirect_to checklists_path, notice: "Checklist was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist
      @checklist = Checklist.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def checklist_params
      params.expect(checklist: [ :title, :country, :category, :content ])
    end
end
