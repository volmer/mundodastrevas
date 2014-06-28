module Raddar
  module Admin
    module Zines
      class ZinesController < Raddar::ApplicationController
        before_action :set_zine, only: [:edit, :update]

        def index
          authorize(Raddar::Zines::Zine.new)

          @zines = Raddar::Zines::Zine.order('name ASC').page(params[:page])
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

            redirect_to admin_zines_path, notice: t('flash.zines.zines.update')
          else
            render action: 'edit'
          end
        end

        private

        def set_zine
          @zine = Raddar::Zines::Zine.find_by!(slug: params[:id])

          @zine.define_singleton_method(:policy_class) do
            Raddar::Zines::Admin::ZinePolicy
          end

          authorize(@zine)
        end

        def zine_params
          params.require(:zine).permit(:starred)
        end
      end
    end
  end
end
