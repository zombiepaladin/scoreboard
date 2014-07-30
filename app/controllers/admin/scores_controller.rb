class Admin::ScoresController < ApplicationController
  before_filter :login_required, :admin_required
  before_filter :find_score, only: [:approve, :deny]

  def approve
    if @score.approve!
      AdminAction.create(admin: current_user, user: @score.user, description: "Approved Score #{@score.inspect}")
      redirect_to :back, notice: "Approved score successfully."
    else
      redirect_to :back, alert: "Unable to approve score."
    end
  end

  def deny
    if @score.deny!
      AdminAction.create(admin: current_user, user: @score.user, description: "Denied Score #{@score.inspect}")
      redirect_to :back, notice: "Denied score successfully."
    else
      redirect_to :back, alert: "Unable to deny score."
    end
  end
  
  def remove_duplicates
    Score.where(task_id: 12).each {|s| s.destroy}
    #User.all.each do |user|
    #  user.scores.group(:task_id).count.each do |task, count|
    #    if(count && count > 0)
    #      user.scores.where(task_id: task).each_with_index do |score, index|
    #    score.destroy unless index == 0 || score.admin_override?
    #      end
    #    end
    #  end
    #end
    redirect_to "", alert: "Duplicate scores removed!"
  end
  
  def recalculate_scores
    User.all.each{|u| u.update_scores!}
    redirect_to :root, alert: "Scores recalculated"
  end

  protected

  def find_score
    @score = Score.find(params[:id])
  end
end
