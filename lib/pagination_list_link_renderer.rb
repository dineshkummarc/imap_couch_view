class WillPaginate::Collection
  attr_accessor :prev_startkey, :next_startkey
end

class PaginationListLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

  protected

  def previous_page
    previous_or_next_page(@collection.previous_page, @options[:previous_label], 'previous_page')
  end

  def next_page
    previous_or_next_page(@collection.next_page, @options[:next_label], 'next_page')
  end

  private

  def link(text, target, attributes = {})
    my_target = target.to_s
    my_target += "?next_startkey=#{@collection.next_startkey}"
    my_target += "?prev_startkey=#{@collection.prev_startkey}"
    attributes[:rel] = rel_value(target)
    target = url(my_target)
    attributes[:href] = target
    tag(:a, text, attributes)
  end

end
