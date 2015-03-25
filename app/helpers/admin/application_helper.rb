module Admin
  module ApplicationHelper
    def admin_list_item(domain, options = {})
      text = t("admin.#{domain}.index.title")
      link = link_to(text, [:admin, domain])
      options[:class] = 'active' if params[:controller] == "admin/#{domain}"

      content_tag(:li, link, options)
    end

    def admin_thead(klass, attribute, direction: 'asc')
      if params[:order].try(:key?, attribute)
        direction = params[:order][attribute] == 'asc' ? 'desc' : 'asc'
      end

      url_params = params.merge(order: { attribute => direction })

      link_to(klass.human_attribute_name(attribute), url_params)
    end
  end
end
