module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings,
             as: :taggable,
             dependent: :destroy
    after_save :set_taggings

    def tags
      if tags_changed?
        @tag_names
      else
        taggings.reload.map { |t| t.tag.to_s }.join(', ')
      end
    end

    def tags=(tag_names)
      return if tags == tag_names

      @tag_names = tag_names
      @tags_changed = true
    end

    def tags_changed?
      @tags_changed.present?
    end

    def set_taggings
      if @tags_changed
        tag_names_array = tags.split(',').map { |t| t.strip.downcase }

        reload.taggings.destroy_all

        tag_names_array.each do |tag_name|
          tag = Tag.find_or_create_by(name: tag_name)

          taggings.create(tag: tag)
        end

        @tags_changed = false
      end

      self
    end
  end
end
