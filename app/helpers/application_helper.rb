module ApplicationHelper
  
  # TODO: refactor these ( tree_select and options_for_tree_select ) methods and inject to ActionView::Helpers::FormTagHelper
  def tree_select(object, tree, selected = nil, include_blank = false)
    html = ""
    html << "<select id=\"#{object.class.name.downcase}_parent_id\" name=\"#{object.class.name.downcase}[parent_id]\" >"
    html << "<option></option>" if include_blank

    tree.roots.each do |root|
      html << options_for_tree_select(root, selected)
    end
    html << "</select>"
    html.html_safe
  end

  def options_for_tree_select(option, selected = nil)
    html = ""
    html << "<option value='#{option.id}' "
    html << "selected=\"selected\"" if option.id == selected
    html << ">#{'&nbsp;'*option.depth*2}&raquo;#{option.name}</option>"
    if option.has_children?
      option.children.each do |child|
        html << options_for_tree_select(child, selected)
      end
    end
    html.html_safe
  end
end
