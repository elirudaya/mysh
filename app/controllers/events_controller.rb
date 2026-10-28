class EventsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = Event.order(date: :asc)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      redirect_to admin_event_path(@event), notice: "Мероприятие создано"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), notice: "Мероприятие обновлено"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @event.destroy!
    redirect_to admin_events_path,
                notice: "Мероприятие удалено",
                status: :see_other
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :date, :city, :address, :capacity, :image
    )
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
