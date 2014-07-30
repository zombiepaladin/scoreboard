class Admin::ReportsController < ApplicationController
  layout "admin"
  before_filter :login_required, :admin_required

  def player_timelines
    @players = User.players 
  end

  def player_details
    @players = User.players
    render xlsx: "player_details", filename: "player_details_#{Date.today}"
  end

  def task_details
    @tasks = Task.all
    render xlsx: "task_details", filename: "task_details_#{Date.today}"
  end

  def mailing_list 
    emails = User.pluck(:eid).map{|eid| "#{eid}@k-state.edu"}
    send_data emails.join(', '), :filename => "rpo_maling_list.txt"
  end
  
end
