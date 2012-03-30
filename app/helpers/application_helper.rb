module ApplicationHelper
  def logo
    image_tag("logo.png", :alt => "Logo", :class => "round")
  end

  def title
    base_title = "Todo list"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
