module ApplicationHelper
  def auth_links(style = "")
    if current_user.is_a?(GuestUser)
      (link_to "Sign up", new_user_registration_path, class: style) +
      " ".html_safe +
      (link_to "Login", new_user_session_path, class: style)
    else
      link_to "Logout", destroy_user_session_path, class: style, data: { "turbo-method": :delete }
    end
  end

  def source_greeting
    return unless session[:source]

    content_tag(:p, greeting, class: "source-greeting")
  end

  def copyright
    TzViewTool::Renderer.copyright("Tania Zavediuk", "All rights reserved")
  end

  def nav_generator(tag_type, style)
    nav_links = ""

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active?(item[:url])}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
  end

  def nav_items
    [
      {
        url: root_path,
        title: "Home"
      },
      {
        url: about_path,
        title: "About Me"
      },
      {
        url: contact_path,
        title: "Contact"
      },
      {
        url: blogs_path,
        title: "Blog"
      },
      {
        url: portfolios_path,
        title: "Portfolio"
      },
    ]
  end

  def toast_messages
    return if flash.empty?

    result = ""

    flash.each do |type, message|
      result +=
        if type == "notice"
          generate_toast(message, "text-bg-success")
        else
          generate_toast(message)
        end
    end

    result.html_safe
  end

  def generate_toast(msg, style = "text-bg-danger")
    render(
      partial: "shared/toast",
      locals: { msg: msg, style: style }
    )
  end

  private

    def greeting
      "Thanks for visiting me from #{session[:source]}!"
    end

    def active?(path)
      "active" if current_page?(path)
    end
end
