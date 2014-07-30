module Admin::TasksHelper
  def all_tasks_chart_data
    first_completion_at = Score.order("created_at").first().try(:created_at) || 3.weeks.ago
    first_completion_at -= 1.day
    tasks_by_day = Score.group("date(scores.created_at)").count()
    data = (first_completion_at.to_date..Date.today).map do |date|
      {
        date: date,
        count: tasks_by_day[date.to_s] || 0
      }
    end
  end
end
