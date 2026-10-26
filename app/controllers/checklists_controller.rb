class ChecklistsController < ApplicationController
  layout "application"

  before_action :authenticate_user!,
                except: [ :index, :show ]

  before_action :set_checklist,
                only: [ :show, :edit, :update, :destroy ]

  def index
    @checklists = Checklist.joins(:user)
                          .where(users: { admin: true })
                          .order(created_at: :desc)

    @checklist = Checklist.new
  end

  def show
    authorize! :read, @checklist
  end

  def new
    @checklist = Checklist.new
    authorize! :create, @checklist
  end

  def edit
    authorize! :update, @checklist
  end

  def create
    @checklist = current_user.checklists.new(checklist_params)
    authorize! :create, @checklist

    if @checklist.save
      redirect_to @checklist, notice: "Гайд опубликован"
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    authorize! :update, @checklist

    if @checklist.update(checklist_params)
      redirect_to @checklist, notice: "Изменения сохранены"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize! :destroy, @checklist
    @checklist.destroy!
    redirect_to checklists_path, notice: "Гайд удалён"
  end

  private

  def set_checklist
    @checklist = Checklist.find(params[:id])
  end

  def checklist_params
    params.require(:checklist).permit(
      :title, :country, :category, :content
    )
  end
end
