module ApplicationHelper
  include Twitter::Autolink

  def twitter_text(text)
    text = auto_link(text)
    text ? text.html_safe : ''
  end
end
