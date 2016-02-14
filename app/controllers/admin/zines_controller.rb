module Admin
  class ZinesController < Admin::ApplicationController
    def index
      authorize(Zine.new)

      @zines = Zine.order(params[:order]).order(
        name: :asc).page(params[:page]).per(20)
    end
  end
end
