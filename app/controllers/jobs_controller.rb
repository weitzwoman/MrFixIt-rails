class JobsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  before_action :authenticate_worker!, :only => [:update]

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def show
    @job = Job.find(params[:id])
    @worker = current_worker
  end

  def create
    @user = current_user.id
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      flash[:alert] = "Error: Job Not Created"
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    if current_worker
      if params[:completed] && params[:active]
        @job.update(completed: params[:completed], active: params[:active])
        respond_to do |format|
          format.html { redirect_to job_path(@job) }
          format.js
        end
      elsif @job.update(pending: true, worker_id: current_worker.id)
        respond_to do |format|
          format.html {redirect_to worker_path(current_worker)}
          format.js {render 'update'}
        end
        flash[:notice] = "You've successfully claimed this job."
      else
        flash[:alert] = "Something went wrong!"
        render :show
      end
    else
      flash[:notice] = 'You must have a worker account to claim a job. Register for one using the link in the navbar above.'
      redirect_to job_path(@job)
    end
  end

private
  def job_params
    params.require(:job).permit(:title, :description, :user_id)
  end
end
