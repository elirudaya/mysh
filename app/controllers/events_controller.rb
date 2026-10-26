class EventsController < ApplicationController
  layout "application"

  before_action :authenticate_user!,
                except: [ :index, :show ]

  before_action :set_event,
                only: [ :show, :edit, :update, :destroy ]

  def index
    @events = Event.joins(:user)
                  .where(users: { admin: true })
                  .order(created_at: :desc)

    @event = Event.new
  end

  def show
    authorize! :read, @event
  end

  def new
    @event = Event.new
    authorize! :create, @event
  end

  def edit
    authorize! :update, @event
  end

  def create
    @event = current_user.events.new(event_params)
    authorize! :create, @event

    if @event.save
      redirect_to @event, notice: "Мероприятие опубликовано"
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    authorize! :update, @event

    if @event.update(event_params)
      redirect_to @event, notice: "Изменения сохранены"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize! :destroy, @event
    @event.destroy!
    redirect_to events_path, notice: "Мероприятие удалено"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :date,
      :city, :address, :capacity
    )
  end
end
