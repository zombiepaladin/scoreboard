module Admin::LoginsHelper
  def logins_chart_data
    first_login_at = DailyPing.order(:date).first().try(:date) || 3.weeks.ago
    first_login_at -= 1.day
    logins = DailyPing.group(:date).count()
    data = (first_login_at.to_date..Date.today).map do |date|
      {
        date: date,
        total: logins[date] || 0
      }
    end
  end
end
