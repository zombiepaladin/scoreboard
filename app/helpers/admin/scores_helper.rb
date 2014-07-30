module Admin::ScoresHelper
  def scores_chart_data
    first_completion_at = Score.order("created_at").first().try(:created_at) || 3.weeks.ago
    first_completion_at -= 1.day
    total_scores = Score.group("date(scores.created_at)").sum(:points)
    admin_granted = Score.where("admin_id IS NOT NULL").group("date(scores.created_at)").sum(:points)
    data = (first_completion_at.to_date..Date.today).map do |date|
      {
        date: date,
        total: total_scores[date.to_s] || 0,
        admin: admin_granted[date.to_s] || 0
      }
    end
  end
end
