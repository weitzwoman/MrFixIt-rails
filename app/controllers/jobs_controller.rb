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
      if @job.update(pending: true, worker_id: current_worker.id)
        respond_to do |format|
          flash[:notice] = "You've successfully claimed this job."
          format.html {redirect_to worker_path(current_worker)}
          format.js {render 'update'}
        end
      else
        flash[:alert] = "Something went wrong!"
        render :show
      end
    else
      # We need to streamline this process better in the future! - Mr. Fix-It.
      flash[:notice] = 'You must have a worker account to claim a job. Register for one using the link in the navbar above.'
      redirect_to job_path(@job)
    end
  end

  def job_active
    @job = Job.find(params[:id])
    if current_worker
      if @job.update(active: true, worker_id: current_worker.id)
        respond_to do |format|
          flash[:notice] = "Complete Job"
          format.html {redirect_to worker_path(current_worker)}
          format.js {render 'update'}
        end
      else
        flash[:alert] = "Something went wrong!"
        render :show
      end
    else
      flash[:notice] = "something else happened"
      redirect_to job_path(@job)
    end
  end

  def job_complete
    @job = Job.find(params[:id])
    if current_worker
      if @job.update(completed: true, worker_id: current_worker.id)
        respond_to do |format|
          flash[:notice] = "Complete Job"
          format.html {redirect_to worker_path(current_worker)}
          format.js {render 'update'}
        end
      else
        flash[:alert] = "Something went wrong!"
        render :show
      end
    else
      flash[:notice] = "something else happened"
      redirect_to job_path(@job)
    end
  end

private
  def job_params
    params.require(:job).permit(:title, :description, :user_id)
  end
end
