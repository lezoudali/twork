module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-success alert-dismissable"
      when :info then "alert alert-info alert-dismissable"
      when :alert then "alert alert-danger alert-dismissable"
      when :warning then "alert alert-warning alert-dismissable"
    end
  end

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end
end