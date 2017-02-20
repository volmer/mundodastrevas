class PostsController < ApplicationController
  before_action :set_zine, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    authorize(Post.new)

    @posts = Post.order(created_at: :desc).limit(10)
  end

  def show
    @post.update_column(:views, @post.views + 1)
    @comments = @post.comments.includes(:user).order(created_at: :asc)

    @comment = @post.comments.new
  end

  def new
    @post = @zine.posts.new

    authorize(@post)
  end

  def edit; end

  def create
    @post = @zine.posts.new(post_params)
    @post.user = current_user

    authorize(@post)

    if @post.save
      redirect_to [@zine, @post], notice: t('flash.posts.create')
    else
      render action: 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to [@zine, @post], notice: t('flash.posts.update')
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy

    redirect_to @zine, notice: t('flash.posts.destroy')
  end

  private

  def set_zine
    @zine = Zine.find_by!(slug: params[:zine_id])
  end

  def set_post
    @post = @zine.posts.find_by!(slug: params[:id])

    authorize(@post)
  end

  def post_params
    params.require(:post).permit(:name, :image, :content, :slug, :tags)
  end
end
