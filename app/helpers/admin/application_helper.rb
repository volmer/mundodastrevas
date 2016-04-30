module Admin
  module ApplicationHelper
    def admin_list_item(domain, options = {})
      text = t("admin.#{domain}.index.title")
      link = link_to(text, [:admin, domain])
      options[:class] = 'active' if params[:controller] == "admin/#{domain}"

      content_tag(:li, link, options)
    end
  end
end
