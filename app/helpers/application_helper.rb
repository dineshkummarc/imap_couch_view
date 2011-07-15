module ApplicationHelper

  def format_datetime(datetime)
    datetime.strftime('%Y-%m-%d %H:%M') if datetime.respond_to?(:strftime)
  end

  def link_email_array(arr)
    arr.map! do |a|
      link_to(h(a), imap_index_path(:q=>a))
    end
    arr.join(', ') 
  end

  def show_val(v)
    if v.is_a?(Array)
      v.join(', ')
    else
      v
    end
  end


end
