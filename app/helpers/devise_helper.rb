
module DeviseHelper
  def bootstrap_alert(key)
    case key
    when "alert"
      "danger"
    when "notice"
      "dark"
    when "error"
      "danger"
    when "danger"
      "danger"
    when "info"
      "info"
    when "success"
      "success"
    when "warning"
      "warning"
    end
  end
end
