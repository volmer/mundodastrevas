require 'rails_helper'

describe ReviewsHelper, type: :helper do
  describe '#review_by_current_user' do
    let(:reviewable) { create(:post) }
    let(:current_user) { create(:user) }

    before { allow(helper).to receive(:current_user).and_return(current_user) }

    it 'is the review that belongs to reviewable and to the current user' do
      review = create(:review, reviewable: reviewable, user: current_user)
      create_list(:review, 3, reviewable: reviewable)
      reviewable.reviews << review

      expect(helper.review_by_current_user(reviewable)).to eq(review)
    end

    context 'when there is no review by the current user' do
      it 'is a new review with the given reviewable and current user' do
        review = helper.review_by_current_user(reviewable)

        expect(review).not_to be_persisted
        expect(review.user).to eq(current_user)
        expect(review.reviewable).to eq(reviewable)
      end
    end
  end

  describe '#review_btn_class' do
    let(:review) { create(:review) }

    before { allow(helper).to receive(:user_signed_in?).and_return(true) }

    it 'is btn btn-default and the given value' do
      expect(helper.review_btn_class('amazing', review)).to eq(
        'btn btn-default amazing'
      )
    end

    context 'when the review value is equal to the given value' do
      before { review.value = 'amazing' }

      it 'is also active' do
        expect(helper.review_btn_class('amazing', review)).to eq(
          'btn btn-default amazing active'
        )
      end
    end

    context 'when user is not signed in' do
      before { allow(helper).to receive(:user_signed_in?).and_return(false) }

      it 'is also disabled' do
        expect(helper.review_btn_class('amazing', review)).to eq(
          'btn btn-default amazing disabled'
        )
      end
    end
  end
end
