class UsersController < ApplicationController
  before_filter :login_required
  before_filter :acceptance_required, except: :accept_terms
  
  def show
    @user = User.find(params[:id])
    unless current_user.admin? || @user == current_user
      redirect_to "/", alert: "You cannot access that player's profile page." and return
    end
    @user.update_scores!
    @milestones = @user.milestones.order("scores.created_at asc")
    @scores = @user.scores.includes(:task).order("scores.created_at asc") # .where("tasks.milestone = ?", false)
  end
  
  def edit
    @user = User.find(params[:id])
    unless current_user.admin? || @user == current_user
      redirect_to "/", alert: "You cannot change that player's handle." and return
    end
  end  
  
  def update
    @user = User.find(params[:id])
    unless current_user.admin? || @user == current_user
      redirect_to "/", alert: "You cannot change that player's handle." and return
    end
    
    name = params[:user][:name]
    if Blacklist.on_list? name
      redirect_to edit_user_path(@user), alert: "The name '#{name}' is inappropriate." and return
    end
    @user.name = name
    @user.save
    
    @milestones = @user.milestones.order("scores.created_at asc")
    @scores = @user.scores.includes(:task).order("scores.created_at asc") # .where("tasks.milestone = ?", false)
    render action: :show
  end  
  
  def accept_terms
    @user = User.find(params[:id])
    unless @user == current_user
      render "/rules/terms_and_conditions", alert: "You cannot accept terms and conditiosn for another player."
    end
    
    @user.accepted_terms_and_conditions = true
    @user.save
    redirect_to "/", notice: "Play on!"
  end
  
end
