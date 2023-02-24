class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[show update destroy]
  before_action :set_job, only: %i[index create]

  def index
    @shifts = @job.shifts
  end

  def show
  end

  def create
    @shift = @job.shifts.build(shift_params)

    if @shift.save
      render :show, status: :created, location: @shift
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def update
    if @shift.update(shift_params)
      render :show, status: :ok, location: @shift
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @shift.destroy

    head :no_content
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def set_job
    @job = Job.find(params[:job_id])
  end

  def shift_params
    params.require(:shift).permit(:start_time, :end_time)
  end
end
