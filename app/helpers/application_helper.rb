# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include LoginEngine
  
  def flash_div *keys
    keys.collect { |key| content_tag(:div, flash[key],
                                     :class => "flash #{key}") if flash[key] }.join
  end

  
end
