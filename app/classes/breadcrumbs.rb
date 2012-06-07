class Breadcrumbs < SimpleNavigation::Renderer::Breadcrumbs

  def render(item_container)
    content_tag(:ul, a_tags(item_container).join(), {:id => item_container.dom_id, :class => "breadcrumb"})
  end

  protected

  def tag_for(item)
    li_content = "#{super}"
    li_content << " <span class='divider'>/</span>" unless item.active_leaf_class
    content_tag(:li, li_content)
  end
end
