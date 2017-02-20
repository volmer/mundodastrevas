module Admin
  class PagesController < Admin::ApplicationController
    before_action :set_page, only: [:edit, :update, :destroy]

    def index
      @pages = Page.order(title: :asc).page(params[:page])
      authorize(Page.new)
    end

    def new
      @page = Page.new
      authorize(@page)
    end

    def edit; end

    def create
      @page = Page.new(page_params)

      authorize(@page)

      if @page.save
        redirect_to @page, notice: t('flash.admin.pages.create')
      else
        render action: 'new'
      end
    end

    def update
      if @page.update(page_params)
        redirect_to @page, notice: t('flash.admin.pages.update')
      else
        render action: 'edit'
      end
    end

    def destroy
      @page.destroy
      redirect_to admin_pages_url, notice: t('flash.admin.pages.destroy')
    end

    private

    def set_page
      @page = Page.find_by!(slug: params[:id])
      authorize(@page)
    end

    def page_params
      params.require(:page).permit(
        :content, :title, :slug, :bootsy_image_gallery_id
      )
    end
  end
end
