module Raddar
  module Admin
    class ZinesController < Raddar::ApplicationController
      before_action :set_zine, only: [:edit, :update]

      def index
        authorize(Zine.new)

        @zines = Zine.order('name ASC').page(params[:page]).per(20)
      end

      def edit
      end

      def update
        if @zine.update(zine_params)
          if params[:featured]
            Setting[:featured_zine] = @zine.id
          elsif Setting[:featured_zine] == @zine.id.to_s
            Setting[:featured_zine] = nil
          end

          redirect_to admin_zines_path, notice: t('flash.zines.update')
        else
          render action: 'edit'
        end
      end

      private

      def set_zine
        @zine = Zine.find_by!(slug: params[:id])

        @zine.define_singleton_method(:policy_class) do
          ::Admin::ZinePolicy
        end

        authorize(@zine)
      end

      def zine_params
        params.require(:zine).permit(:starred)
      end
    end
  end
end
