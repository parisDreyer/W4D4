module ApplicationHelper

  def authentication
    "
    <input
      type=\"hidden\"
      name=\"authenticity_token\"
      value=\"<#{ h(form_authenticity_token) }\"
      >
    ".html_safe
  end


  def user_interaction(user)
    if user
      "<a href=\"#{ h(user_url(user)) }\">Hello, #{ h(user.username) }</a>
      <form action=\"#{ session_url(user) }\" method=\"post\">
        #{ h(authentication) }
        <input type=\"hidden\" name=\"_method\" value=\"delete\">
        <input type=\"submit\" value=\"Logout!\">
      </form>
    ".html_safe
    else
      "<a href=\"#{new_user_url}\">Create New User</a>".html_safe
    end
  end
end
