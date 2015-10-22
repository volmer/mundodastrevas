require 'rails_helper'

describe Followership do
  subject { build(:followership) }

  it 'ensures that users do not follow themselves' do
    user = create(:user)

    followership = build(:followership, user: user, followable: user)

    expect(followership).not_to be_valid
  end

  context 'when a record is created' do
    it 'creates an activity' do
      subject

      expect {
        subject.save
      }.to change{
        Activity.count
      }.by(1)

      activity = Activity.last

      expect(activity.user).to eq(subject.user)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('followerships.create')
      expect(activity.privacy).to eq('public')
    end

    it 'creates a new notification for the followed user' do
      expect {
        subject.save
      }.to change { subject.followable.notifications.count }.by(1)
    end

    it 'delivers a notification email to the followed user' do
      subject

      expect {
        subject.save
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(ActionMailer::Base.deliveries.last.to).to match_array(
        [subject.followable.email])
    end

    context 'the followed user does not want to receive emails' do
      before do
        subject.followable = create(
          :user, email_preferences: { new_follower: 'false' }
        )
      end

      it 'does not deliver a notification email' do
        expect {
          subject.save
        }.not_to change { ActionMailer::Base.deliveries.count }
      end
    end
  end
end
