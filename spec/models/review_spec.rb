require 'rails_helper'

describe Review do
  subject { build(:review) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:reviewable) }
    it { is_expected.to have_one(:activity).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:reviewable_id) }
    it { is_expected.to validate_inclusion_of(:value).in_array(['loved', 'hated']) }

    it 'validates uniqueness of user_id scoped to reviewable' do
      expect(subject.save).to be true

      other = build(:review)

      expect(other).to be_valid

      other.user = subject.user

      expect(other).to be_valid

      other.reviewable = subject.reviewable

      expect(other).not_to be_valid
    end
  end

  context 'when a love record is created' do
    subject! { build(:review, value: 'loved') }

    it 'creates a public activity' do
      expect {
        subject.save!
      }.to change{
        Activity.count
      }.by(1)

      activity = Activity.last

      expect(activity.user).to eq(subject.user)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('reviews.create')
      expect(activity.privacy).to eq('public')
    end
  end

  context 'when a hate record is created' do
    subject! { build(:review, value: 'hated') }

    it 'creates a public activity' do
      expect {
        subject.save!
      }.to change{
        Activity.count
      }.by(1)

      activity = Activity.last

      expect(activity.user).to eq(subject.user)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('reviews.create')
      expect(activity.privacy).to eq('only_me')
    end
  end

  context 'when it changes' do
    context 'from loved to hated' do
      it 'sets the associated activity to only_me' do
        review = create(:review, value: 'loved')
        activity = Activity.last
        review.update!(value: 'hated')
        activity.reload

        expect(activity.privacy).to eq('only_me')
      end
    end

    context 'from hated to loved' do
      it 'sets the associated activity to public' do
        review = create(:review, value: 'hated')
        activity = Activity.last
        review.update!(value: 'loved')
        activity.reload

        expect(activity.privacy).to eq('public')
      end
    end
  end
end
