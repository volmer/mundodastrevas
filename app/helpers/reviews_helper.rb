module ReviewsHelper
  def review_by_current_user(reviewable)
    reviewable.reviews.find_or_initialize_by(user: current_user)
  end

  def review_btn_class(value, review)
    classes = ['btn', 'btn-secondary', value]
    classes << 'disabled' unless user_signed_in?
    classes << 'active' if review.value == value
    classes.join(' ')
  end
end
