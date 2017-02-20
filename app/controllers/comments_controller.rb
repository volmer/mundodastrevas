class CommentsController < ApplicationController
  before_action :set_zine
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    authorize(@comment)

    if @comment.save
      redirect_to [@zine, @post], notice: t('flash.comments.create')
    else
      @comments = @post.comments.order(created_at: :asc)
      render(template: 'posts/show')
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    authorize(@comment)

    @comment.destroy

    redirect_to [@zine, @post], notice: t('flash.comments.destroy')
  end

  private

  def set_zine
    @zine = Zine.find_by!(slug: params[:zine_id])
  end

  def set_post
    @post = @zine.posts.find_by!(slug: params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
