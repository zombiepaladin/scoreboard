require 'encryptor'

class TasksController < ApplicationController
  before_filter :login_required, except: [:complete_by_encrypted_package]
  before_filter :acceptance_required, except: [:complete_by_encrypted_package]
  before_filter :find_task, only: [:show, :solve]

  def index
    @tasks = Task.active.order(:position).all
  end

  def solve
    @task = Task.find(params[:id])
    
    unless @task.solution.downcase.split("|").include? params[:solution].downcase
      redirect_to task_path(@task), alert: "Your solution was incorrect" and return
    end
    
    @score = @task.complete!(current_user)
    if @score.save
      flash[:cryptic] = @task.feedback unless @task.feedback.blank?
      redirect_to user_path(current_user), notice: "Congratulations! You received #{@score.points} points for completing the '#{@task.name}' task."
    else
      redirect_to task_path(@task), alert: @score.errors[:base].join('\n')
    end
  end

  def complete_by_signature
    @task = Task.find(params[:id])

    unless @task.signature == params[:signature]
      redirect_to user_path(current_user), alert: "The QR signature URL you supplied was invalid." and return
    end

    @score = @task.complete!(current_user)
    if @score.save
      redirect_to user_path(current_user), notice: "Congratulations! You received #{@score.points} points for completing the '#{@task.name} task by QR code."
    else
      redirect_to user_path(current_user), alert: "Encountered a problem while trying to complete task by QR Code."
    end
  end

  def complete_by_encrypted_package
    task_token, user_id = *Encryptor.decrypt(params[:package]).split(",")

    @task = Task.find_by_token!(task_token)
    @user = User.find_by_id!(user_id)

    score = @task.complete!(@user)
    if score.save
      render text: "Awarded #{score.points} points to #{@user.name} for completing '#{@task.name}'"
    else
      render text: "There was a problem with the encrypted package [#{score.errors[:base].join(',')}], could not complete task."
    end
  end

  protected

  def find_task
    @task = Task.find(params[:id])
  end
end
