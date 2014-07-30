class BoardsController < ApplicationController
  def index
    @search = params[:search]
    @users = User.players.order("score desc").paginate(page: params[:page], per_page: 50)
    @next_page_path = boards_path(page: @users.next_page)
    render partial: "boards/user", collection: @users if request.xhr?
  end

  def show
    @search = params[:search]
    @category = params[:id]
    @users = User.players.order("score_#{@category.underscore} desc").paginate(page: params[:page], per_page: 50)
    @next_page_path = board_path(@category, page: @users.next_page)
    render partial: "boards/user", collection: @users and return if request.xhr?
    render action: :index
  end
end
