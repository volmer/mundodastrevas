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

    respond_to_create
  end

  def destroy
    @followership = Followership.find(params[:id])
    @followable = @followership.followable
    authorize(@followership)

    @followership.destroy

    respond_to do |format|
      format.html do
        redirect_to(
          @followable, notice: t(
            'flash.followerships.destroy', followable: @followable.name
          )
        )
      end

      format.json { head :no_content }
    end
  end

  private

  def find_followable
    key, value = params.select { |k, _| k.end_with?('_id') }.first

    if key == 'user_id'
      User.find_by_name!(value)
    else
      key[0..-4].classify.constantize.find(value)
    end
  end

  def respond_to_create
    respond_to do |f|
      if FollowershipCompletion.new(@followership).create
        f.html do
          redirect_to @followable, notice: t(
            'flash.followerships.create', followable: @followable.name
          )
        end
        f.json do
          render action: 'show', status: :created, location: @followership
        end
      else
        f.html { redirect_to @followable, alert: 'Error.' }
        f.json { render json: @followership, status: :unprocessable_entity }
      end
    end
  end
end
