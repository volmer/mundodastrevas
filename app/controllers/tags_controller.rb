class TagsController < ApplicationController
  def show
    @tag = Tag.find_by!(name: params[:id])

    authorize(@tag)

    @taggings = @tag.taggings.page(params[:page])
  end
end
