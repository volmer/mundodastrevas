class ZinesController < ApplicationController
  before_action :set_zine, only: [:show, :edit, :update, :destroy]

  def index
    authorize(Zine.new)

    if params[:user_id]
      user_zines_index
    else
      zines_index
    end
  end

  def show
    @posts = @zine.posts.order(created_at: :desc).page(params[:page])
  end

  def new
    @zine = Zine.new

    authorize(@zine)
  end

  def edit; end

  def create
    @zine = Zine.new(zine_params)
    @zine.user = current_user

    authorize(@zine)

    if @zine.save
      redirect_to @zine, notice: t('flash.zines.create')
    else
      render action: 'new'
    end
  end

  def update
    if @zine.update(zine_params)
      redirect_to @zine, notice: t('flash.zines.update')
    else
      render action: 'edit'
    end
  end

  def destroy
    @zine.destroy

    redirect_to zines_path, notice: t('flash.zines.destroy')
  end

  private

  def set_zine
    @zine = Zine.find_by!(slug: params[:id])

    authorize(@zine)
  end

  def zine_params
    params.require(:zine).permit(
      :name, :slug, :description, :image, :universe_id
    )
  end

  def user_zines_index
    @user = User.find_using_nme!(params[:user_id])

    @zines = @user.zines.order(
      'COALESCE(last_post_at, created_at) DESC'
    ).page(params[:page])

    render 'user_index'
  end

  def zines_index
    @zines = Zine.with_posts.order(
      last_post_at: :desc
    ).page(params[:page])

    @tags = Tag.trending.limit(8)

    @most_read_posts = Post.order(views: :desc).limit(5)
  end
end
