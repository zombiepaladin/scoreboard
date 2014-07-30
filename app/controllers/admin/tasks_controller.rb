class Admin::TasksController < ApplicationController
  layout "admin"
  
  before_filter :login_required, :admin_required
  before_filter :find_task, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tasks = Task.order(:position).all
    respond_with @tasks
  end
  
  def sort
    params[:task].each_with_index do |id, index|
      Task.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to admin_tasks_path, notice: "Task '#{@task.name}' created successfully."
    else
      flash.now[:alert] = "There was a problem creating the task"
      render action: :new
    end
  end

  def new
    @task = Task.new
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to admin_tasks_path, notice: "Updated task successfully."
    else
      flash.now[:alert] = "There was a problem updating the task. Check below."
      render action: :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to admin_tasks_path, notice: "Successfully deleted task '#{@task.name}'"
    else
      redirect_to admin_tasks_path, alert: "There was a problem deleting task '#{@task.name}'"
    end
  end

  protected

  def find_task
    @task = Task.find(params[:id])
  end
end
