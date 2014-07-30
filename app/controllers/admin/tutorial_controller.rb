class Admin::TutorialController < ApplicationController
  before_filter :login_required, :admin_required
  
  def change
    @tutorial = Tutorial.new(params[:tutorial])
    if @tutorial.save
      redirect_to :back, notice: "Tutorial video changed successfully."
    else
      redirect_to :back, alert: "Unable to change tutorial video."
    end
  end
  
end
