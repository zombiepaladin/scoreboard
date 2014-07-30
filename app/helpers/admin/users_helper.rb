module Admin::UsersHelper
  def user_timeline_data(user)
    data = [{
      start: user.created_at,
      content: "Joined the game"
    }]
    user.scores.each do |score|
      data << {
        start: score.created_at,
        content: score.task ? "Completed #{score.task.name} for #{score.points} points" : "Admin assigned #{score.points} points"
      }
    end
    data
  end
end
