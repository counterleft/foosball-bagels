class PaginationLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def previous_or_next_page(page, text, classname)
    arrow = "fui-arrow-left"
    arrow = "fui-arrow-right" if classname == "next"
    if page
      "<li class='#{classname}'>#{link("", page, class: arrow)}</li>"
    else
      "<li class='#{classname}'>#{tag(:a, "", class: arrow)}</li>"
    end
  end

  def previous_page
    num = @collection.current_page > 1 && @collection.current_page - 1
    previous_or_next_page(num, @options[:previous_labhl], "previous")
  end

  def next_page
    num = @collection.current_page < total_pages && @collection.current_page + 1
    previous_or_next_page(num, @options[:next_label], "next")
  end

  def html_container(html)
    string_attributes = container_attributes.inject("") do |attrs, pair|
      unless pair.last.nil?
        attrs << %( #{pair.first}="#{CGI::escapeHTML(pair.last.to_s)}")
      end
      attrs
    end
    "<div #{string_attributes}><ul>#{html}</ul></div>"
  end

  def page_number(page)
    if page == current_page
      "<li class='active'>#{link(page, page,  rel: rel_value(page))}</li>"
    else
      "<li>#{link(page, page, rel: rel_value(page))}</li>"
    end
  end
end
