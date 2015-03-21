require 'rails_helper'

describe MessageCompletion do
  subject { described_class.new(message) }
  let(:message) { create(:message, recipient: recipient) }
  let(:recipient) { create(:user) }

  describe '#create' do
    it 'creates a new notification for the recipient' do
      expect {
        subject.create
      }.to change { recipient.notifications.count }.by(1)
    end

    it 'delivers a notification email to the recipient' do
      expect {
        subject.create
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(ActionMailer::Base.deliveries.last.to).to match_array([recipient.email])
    end

    context 'the recipient does not want to receive emails about new messages' do
      let(:recipient) { create(:user, email_preferences: { new_message: 'false' } ) }

      it 'does not deliver a notification email' do
        expect {
          subject.create
        }.not_to change { ActionMailer::Base.deliveries.count }
      end
    end
  end
end
