require 'rails_helper'

describe ExternalAccount do
  subject { build(:external_account) }

  context 'when a record is created' do
    subject! { build(:external_account) }

    it 'creates an activity' do
      expect {
        subject.save!
      }.to change{
        Activity.count
      }.by(1)

      activity = Activity.last

      expect(activity.user).to eq(subject.user)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('external_accounts.create')
      expect(activity.privacy).to eq('public')
    end

    context 'when external accounts are private' do
      before do
        subject.user.privacy = { subject.provider => 'only_me' }
        subject.user.save!
      end

      it 'creates a private activity' do
        expect {
          subject.save!
        }.to change{
          Activity.count
        }.by(1)

        activity = Activity.last

        expect(activity.privacy).to eq('only_me')
      end
    end
  end
end
