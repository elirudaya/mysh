class PlacesController < ApplicationController
  layout "application"

  before_action :authenticate_user!,
                except: [ :index, :show ]

  before_action :set_place,
                only: [ :show, :edit, :update, :destroy ]

  def index
    @places = Place.joins(:user)
                  .where(users: { admin: true })
                  .order(created_at: :desc)

    @place = Place.new
  end

  def show
    authorize! :read, @place
  end

  def new
    @place = Place.new
    authorize! :create, @place
  end

  def edit
    authorize! :update, @place
  end

  def create
    @place = current_user.places.new(place_params)
    authorize! :create, @place

    if @place.save
      redirect_to @place, notice: "Место опубликовано"
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    authorize! :update, @place

    if @place.update(place_params)
      redirect_to @place, notice: "Изменения сохранены"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize! :destroy, @place
    @place.destroy!
    redirect_to places_path, notice: "Место удалено"
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(
      :name, :description, :city,
      :address, :category
    )
  end
end
