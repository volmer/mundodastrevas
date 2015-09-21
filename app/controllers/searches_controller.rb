class SearchesController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]

  def show
    return if params[:q].blank?

    indexes = [Topic, User, Zine, Post, Forum, Page]

    search = Elasticsearch::Model.search(params[:q], indexes)
    @results = search.page(params[:page]).records

    @results.instance_eval('def max_pages; nil; end')
  end
end
