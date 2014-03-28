module ApplicationHelper
  
  def user_role_badge(role)
    badge = case role
      when "admin" then "badge badge-important"
      when "mentor" then "badge badge-success"
      when "mentee" then "badge"
      else
        ""
    end
  end
end
