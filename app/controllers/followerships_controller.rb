class FollowershipsController < ApplicationController
  def followers
    @followable = find_followable

    @followers = @followable.followers.page(params[:page]).per(15)

    authorize(Followership.new)
  end

  def following
    @user = User.find_by_name!(params[:user_id])

    @followerships = @user.followerships.page(params[:page]).per(15)

    authorize(Followership.new)
  end

  def create
    @followable = find_followable
    @followership = @followable.followers.new
    @followership.user = current_user

    authorize(@followership)

    if @followership.save
      respond_to_create
    else
      respond_to_creation_error
    end
  end

  def destroy
    @followership = Followership.find(params[:id])
    authorize(@followership)

    @followership.destroy

    respond_to_destroy
  end

  private

  def find_followable
    key, value = params.find { |k, _| k.end_with?('_id') }

    if key == 'user_id'
      User.find_by_name!(value)
    else
      key[0..-4].classify.constantize.find(value)
    end
  end

  def respond_to_create
    respond_to do |f|
      f.html do
        redirect_to @followable, notice: t(
          'flash.followerships.create', followable: @followable.name
        )
      end

      f.json do
        render action: 'show', status: :created, location: @followership
      end
    end
  end

  def respond_to_creation_error
    respond_to do |f|
      f.html { redirect_to @followable, alert: 'Error.' }
      f.json { render json: @followership, status: :unprocessable_entity }
    end
  end

  def respond_to_destroy
    respond_to do |format|
      format.html do
        @followable = @followership.followable
        redirect_to(
          @followable, notice: t(
            'flash.followerships.destroy', followable: @followable.name)
        )
      end

      format.json { head :no_content }
    end
  end
end
