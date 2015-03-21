module TagsHelper
  def render_tags(taggable)
    links = taggable.taggings.map do |tagging|
      link_to tagging.tag,
              tag_path(tagging.tag),
              class: 'label label-default'
    end

    links.join(' ').html_safe
  end
end
