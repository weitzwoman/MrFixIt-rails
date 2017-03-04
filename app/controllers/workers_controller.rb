class WorkersController < ApplicationController
  before_action :authenticate_worker!

  def show
    @worker = Worker.find(params[:id])
    @jobs = @worker.jobs
    # @active_jobs = @worker.jobs.where(active: true)
    # @complete_jobs = @worker.jobs.where(completed: true)
  end

  def new
    # current_worker refers to a worker account currently logged in. current_user refers to a user account currently logged in.
    if current_worker
      redirect_to worker_path(current_worker)
      flash[:notice] = "You're already logged into a worker account!"
    elsif current_user
      # need to make sure users signing up to be workers are signed out of their user account first. -Mr. Fix-It
    sign_out :user
    redirect_to new_worker_registration_path
    else
      redirect_to new_worker_registration_path
    end
  end

  def worker_active_job
    @worker = Worker.find(params[:worker_id])
    @job = Job.find(params[:job_id])
    @job.toggle_job
    respond_to do |format|
      format.html { redirect_to worker_path(current_worker) }
      format.js
    end
  end

  def worker_complete_job
    @worker = Worker.find(params[:worker_id])
    @job = Job.find(params[:job_id])
    @job.complete_job
    respond_to do |format|
      format.html { redirect_to worker_path(current_worker) }
      format.js
    end
  end

end
