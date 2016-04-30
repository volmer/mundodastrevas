class WatchesController < ApplicationController
  before_action :find_watchable

  def create
    @watch = Watch.new(
      user: current_user,
      watchable: @watchable,
      active: watch_params[:active]
    )

    authorize(@watch)
    set_flash_message if @watch.save
    redirect_to redirect_path
  end

  def update
    @watch = Watch.find(params[:id])
    authorize(@watch)

    @watch.active = watch_params[:active]
    set_flash_message if @watch.save
    redirect_to redirect_path
  end

  private

  def watch_params
    params.require(:watch).permit(:active, :watchable_id, :watchable_type)
  end

  def find_watchable
    @watchable = watch_params[:watchable_type].constantize.find(
      watch_params[:watchable_id]
    )
  end

  def set_flash_message
    flash[:notice] =
      if @watch.active
        t('flash.watches.watch', watchable: find_watchable.to_s)
      else
        t('flash.watches.unwatch', watchable: find_watchable.to_s)
      end
  end

  def redirect_path
    case watch_params[:watchable_type]
    when 'Post'
      zine_post_path(@watchable.zine, @watchable)
    when 'Topic'
      forum_topic_path(@watchable.forum, @watchable)
    end
  end
end
