class SearchesController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]

  def show
    @results = PgSearch.multisearch(params[:query]).page(params[:page])
  end
end
