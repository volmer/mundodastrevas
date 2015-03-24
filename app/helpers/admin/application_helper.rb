module Admin
  module ApplicationHelper
    def admin_list_item(item, options = {})
      text = t("admin.#{item}.index.title")
      link = link_to(text, [:admin, item])
      options[:class] = 'active' if params[:controller] == "admin/#{item}"

      content_tag(:li, link, options)
    end
  end
end
