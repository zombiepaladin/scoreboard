module ApplicationHelper
  def alert_type(flash_key)
    {
      alert: 'error',
      notice: 'success',
      cryptic: 'hint'
    }[flash_key.to_sym] || flash_key.to_s
  end
end
