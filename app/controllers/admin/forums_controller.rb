module Admin
  class ForumsController < ApplicationController
    before_action :set_forum, only: [:edit, :update, :destroy]

    def index
      authorize(Forum.new)
      @forums = Forum.order('name ASC')
    end

    def new
      @forum = Forum.new
      authorize(@forum)
    end

    def edit
    end

    def create
      @forum = Forum.new(forum_params)

      authorize(@forum)

      if @forum.save
        redirect_to url_for(@forum),
                    notice: t('flash.forums.create')
      else
        render action: 'new'
      end
    end

    def update
      if @forum.update(forum_params)
        redirect_to url_for(@forum),
                    notice: t('flash.forums.update')
      else
        render action: 'edit'
      end
    end

    def destroy
      @forum.destroy
      redirect_to admin_forums_path,
                  notice: t('flash.forums.destroy')
    end

    def self.policy_class
      Admin::ForumPolicy
    end

    private

    def set_forum
      @forum = Forum.find_by!(slug: params[:id])
      authorize(@forum)
    end

    def forum_params
      params.require(:forum).permit(:name, :description, :slug)
    end
  end
end
