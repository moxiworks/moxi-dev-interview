class JobsController < ApplicationController
  before_action :set_job, only: %i[show update destroy]
  before_action :set_event, only: %i[index create]

  def index
    @jobs = @event.jobs
  end

  def show
  end

  def create
    @job = @event.jobs.build(job_params)

    if @job.save
      render :show, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      render :show, status: :ok, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy

    head :no_content
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def job_params
    params.require(:job).permit(:name)
  end
end
