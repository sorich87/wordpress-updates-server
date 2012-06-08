class Breadcrumbs < SimpleNavigation::Renderer::Base

  def render(item_container)
      content_tag(:ul, li_tags(item_container).join(join_with), { id: item_container.dom_id, class: "#{item_container.dom_class} breadcrumb" })
  end

  protected

  def li_tags(item_container)
    item_container.items.inject([]) do |list, item|
      if item.selected?
        list << tag_for(item) if item.selected?
        if include_sub_navigation?(item)
          list.concat li_tags(item.sub_navigation)
        end
      end
      list
    end
  end

  def tag_for(item)
    content_tag(:li, "#{super}")
  end

  def join_with
    @join_with ||= options[:join_with] || '<span class="divider">/</span>'.html_safe
  end

  def suppress_link?(item)
    option = options.has_key?(:static_leaf) ? options[:static_leaf] : true
    super || (option && item.active_leaf_class)
  end
end
