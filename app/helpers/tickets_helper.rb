module TicketsHelper

  def tag_cloud(tag_cloud, category_list)
    max, min = 0, 0
    tag_cloud.each_value do |count|
      max = count if count > max
      min = count if count < min
    end

    divisor = ((max - min) / category_list.size) + 1

    tag_cloud.each do |tag, count|
      yield tag, category_list[(count - min) / divisor] 
    end
  end
  
  def tag_url_helper(tag)
    #{'stuff'}
  end

  def admin_tools_for(model)
    type = model.class.to_s.downcase
    tag = [] 
  end

  def onhover_show_admin_tools(id = nil)
    tag = []
    tag << %{ onmouseover="Element.show('note_admin_#{id}');" }
    tag << %{ onmouseout="Element.hide('note_admin_#{id}');" }
    tag
  end

end
