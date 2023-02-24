class VolunteersController < ApplicationController
  before_action :set_volunteer, only: %i[show update destroy]

  def index
    @volunteers = Volunteer.all
  end

  def show
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)

    if @volunteer.save
      render :show, status: :created, location: @volunteer
    else
      render json: @volunteer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @volunteer.update(volunteer_params)
      render :show, status: :ok, location: @volunteer
    else
      render json: @volunteer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @volunteer.destroy

    head :no_content
  end

  private

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  def volunteer_params
    params.require(:volunteer).permit(:email)
  end
end
