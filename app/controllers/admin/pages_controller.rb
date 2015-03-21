module Admin
  class PagesController < ApplicationController
    before_action :set_page, only: [:edit, :update, :destroy]

    # GET /pages
    def index
      @pages = Page.order('title ASC').page(params[:page])
      authorize(Page.new)
    end

    # GET /pages/new
    def new
      @page = Page.new
      authorize(@page)
    end

    # GET /pages/1/edit
    def edit
    end

    # POST /pages
    def create
      @page = Page.new(page_params)

      authorize(@page)

      if @page.save
        redirect_to @page, notice: t('flash.admin.pages.create')
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /pages/1
    def update
      if @page.update(page_params)
        redirect_to @page, notice: t('flash.admin.pages.update')
      else
        render action: 'edit'
      end
    end

    # DELETE /pages/1
    def destroy
      @page.destroy
      redirect_to admin_pages_url, notice: t('flash.admin.pages.destroy')
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find_by!(slug: params[:id])
      authorize(@page)
    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params.require(:page).permit(
        :content, :title, :slug, :bootsy_image_gallery_id
      )
    end
  end
end
