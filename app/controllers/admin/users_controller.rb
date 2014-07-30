class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :login_required, :admin_required
  before_filter :find_user, only: [:history, :tasks, :freeze, :unfreeze, :award_points, :complete_task]

  def index
    if params[:filter] == "frozen"
      @users = User.where(freeze_points: true).all
    elsif params[:filter] == "points_modified"
      @users = User.includes(:scores).where("scores.admin_id IS NOT NULL").where("scores.task_id IS NULL").all
    elsif params[:filter] == "tasks_modified"
      @users = User.includes(:scores).where("scores.admin_id IS NOT NULL").where("scores.task_id IS NOT NULL").all
    elsif params[:filter] == "admins"
      @users = User.admins.all
    else
      @users = User.all
    end
  end
  
  def freeze
    @user.freeze_points = true
    if @user.save
      AdminAction.create(admin: current_user, user: @user, description: "Froze user")
      redirect_to history_admin_user_path(@user), notice: "User #{@user.name} frozen successfully."   
    else
      redirect_to history_admin_user_path(@user), alert: "User #{@user.name} could not be frozen."
    end
  end

  def unfreeze
    @user.freeze_points = false
    if @user.save
      AdminAction.create(admin: current_user, user: @user, description: "Unfroze user")
      redirect_to history_admin_user_path(@user), notice: "User #{@user.name} unfrozen successfully."
    else
      redirect_to history_admin_user_path(@user), alert: "User #{@user.name} could not be unfrozen."
    end
  end
  
  def history
    @admin_actions = @user.admin_actions.order("admin_actions.created_at")
  end
  
  def tasks
    @tasks = Task.all
  end

  def award_points
    @score = Score.new({user: @user, admin: current_user, points: params[:score][:points], approved: true}, as: :admin)
    @score.admin_override = true
    if @score.save
      AdminAction.create(admin: current_user, user: @score.user, description: "Awarded #{@score.points} points")
      redirect_to history_admin_user_path(@user), notice: "Awarded #{params[:score][:points]} points to #{@user.name}"
    else
      redirect_to history_admin_user_path(@user), alert: "Could not award #{params[:score][:points]} points to #{@user.name}"
    end
  end
  
  def complete_task
    @task = Task.find(params[:task])
    @score = @task.complete!(@user)
    @score.admin = current_user
    @score.admin_override = true
    if @score.save
      AdminAction.create(admin: current_user, user: @score.user, description: "Marked #{@score.task.name} as complete")
      redirect_to tasks_admin_user_path(@user), notice: "Completed task #{@task.name} for #{@user.name}, awarding #{@score.points} points"
    else
      redirect_to admin_users_path, alert: "Could not complete task #{@task.name} for #{@user.name} because #{@score.errors.full_messages.join(',')}"
    end
  end

  protected

  def find_user
    @user = User.find(params[:id])
  end
end
