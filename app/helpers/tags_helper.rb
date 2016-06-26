module TagsHelper
  def render_tags(taggable)
    links = taggable.taggings.map do |tagging|
      link_to tagging.tag, tag_path(tagging.tag), class: 'label label-default'
    end

    safe_join(links)
  end
end
