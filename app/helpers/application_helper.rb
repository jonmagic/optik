# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include LoginEngine
  
  def flash_div *keys
    keys.collect { |key| content_tag(:div, flash[key],
                                     :class => "flash #{key}") if flash[key] }.join
  end

   def user_collection_select(object, method, collection, value_method, text_method, options = {}, html_options = {})
     options_html = options_from_collection_for_select(collection, value_method, text_method, options[:selected_value])
     first_row = options[:first_row]
     unless first_row.nil?
        first_row_html = content_tag(:option, first_row, :value => session[:user].id)
        options_html = "#{first_row_html}\n#{options_html}"
     end
     html_options[:id] = "#{object.to_s}_#{method.to_s}"
     html_options[:name] = "#{object.to_s}[#{method.to_s}]"
     select_html = content_tag(:select, options_html, html_options)
  end
  
  def textilize(text)
    RedCloth.new(text).to_html
  end  
  
end
