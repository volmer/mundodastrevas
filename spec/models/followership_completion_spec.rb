require 'rails_helper'

describe FollowershipCompletion do
  subject { described_class.new(followership) }
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }
  let(:followership) { create(:followership, user: user, followable: followed_user) }

  describe '#create' do
    it 'creates a new notification for the followed user' do
      expect {
        subject.create
      }.to change { followed_user.notifications.count }.by(1)
    end

    it 'delivers a notification email to the followed user' do
      expect {
        subject.create
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(ActionMailer::Base.deliveries.last.to).to match_array([followed_user.email])
    end

    context 'the followed user does not want to receive emails about new followers' do
      let(:followed_user) { create(:user, email_preferences: { new_follower: 'false' } ) }

      it 'does not deliver a notification email' do
        expect {
          subject.create
        }.not_to change { ActionMailer::Base.deliveries.count }
      end
    end
  end
end
