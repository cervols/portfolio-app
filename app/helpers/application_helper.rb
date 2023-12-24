module ApplicationHelper
  def auth_links
    if current_user.is_a?(GuestUser)
      (link_to "Sign up", new_user_registration_path) +
      "<br />".html_safe +
      (link_to "Login", new_user_session_path)
    else
      button_to "Logout", destroy_user_session_path, method: :delete
    end
  end

  def source_greeting
    return unless session[:source]

    content_tag(:p, greeting, class: "source-greeting")
  end

  def copyright
    TzViewTool::Renderer.copyright("Tania Zavediuk", "All rights reserved")
  end

  private

    def greeting
      "Thanks for visiting me from #{session[:source]}!"
    end
end
