require 'rails_helper'

describe NotificationMailer do
  let(:notification) { create(:notification) }

  describe '#notify' do
    subject { described_class.notify(notification).deliver_now }

    it 'sends the email to the notification user' do
      subject
      expect(ActionMailer::Base.deliveries.last.to).to match_array(
        [notification.user.email])
    end

    it 'includes a link to the notification' do
      subject

      options = Rails.application.config.action_mailer.default_url_options
      notification_url = Rails.application.routes.url_helpers.notification_url(
        notification, options)

      expect(ActionMailer::Base.deliveries.last.body).to include(
        notification_url)
    end

    describe 'new_message' do
      let(:notification) do
        create(:new_message_notification, notifiable: message)
      end

      let(:message) { create(:message, content: 'We do not sow.') }

      subject { described_class.notify(notification).deliver_now }

      it 'sends the proper subject and body' do
        subject

        email = ActionMailer::Base.deliveries.last
        expect(email.subject).to eq("Mensagem de #{message.sender}")
        expect(email.body).to include('We do not sow.')
      end
    end
  end
end
