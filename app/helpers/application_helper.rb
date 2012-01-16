module ApplicationHelper
  def logo
    image_tag("logo.png", :alt => "Logo", :class => "round")
  end
end
