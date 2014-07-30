class TutorialController < ApplicationController
  def index
    @tutorial = Tutorial.order("tutorials.created_at DESC").first()
  end
end
