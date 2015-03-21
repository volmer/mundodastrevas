class ReviewsController < ApplicationController
  def create
    @review = Review.new(user: current_user, reviewable: find_reviewable)

    @review.value = review_params[:value]

    authorize(@review)

    if @review.save
      render json: @review
    else
      render json: { errors: @review.errors.full_messages }, status: 422
    end
  end

  def update
    @review = Review.find(params[:id])

    @review.value = review_params[:value]

    authorize(@review)

    if @review.save
      render json: @review
    else
      render json: { errors: @review.errors.full_messages }, status: 422
    end
  end

  private

  def review_params
    params.require(:review).permit(:value, :reviewable_id, :reviewable_type)
  end

  def find_reviewable
    review_params[:reviewable_type].constantize
      .find(review_params[:reviewable_id])
  end
end
