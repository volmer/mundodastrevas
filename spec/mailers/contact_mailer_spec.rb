require 'rails_helper'

describe ContactMailer do
  let(:contact) do
    Contact.new(
      message: 'Growing strong.',
      name: 'Loras',
      email: 'loras@tyrell.com',
      user: try(:user)
    )
  end

  describe '#contact_email' do
    before { described_class.contact_email(contact).deliver_now }

    it 'sends the email to the address configured as contact destination' do
      expect(ActionMailer::Base.deliveries.last.to).to eq(
        [Rails.application.config.contacts_destination])
    end

    it 'includes the contact message' do
      expect(ActionMailer::Base.deliveries.last.body).to include(
        'Growing strong.')
    end

    it 'includes the contact name' do
      expect(ActionMailer::Base.deliveries.last.body).to include('Loras')
    end

    it 'includes the contact email' do
      expect(ActionMailer::Base.deliveries.last.body).to include(
        'loras@tyrell.com')
    end

    it 'sets the subject' do
      expect(ActionMailer::Base.deliveries.last.subject)
        .to eq('Novo contato de Loras')
    end

    context 'with a contact sent by a signed in user' do
      let(:user) { create(:user) }

      it 'includes a link to the user page' do
        options = Rails.application.config.action_mailer.default_url_options
        user_url = Rails.application.routes.url_helpers.user_url(user, options)

        expect(ActionMailer::Base.deliveries.last.body).to include(user_url)
      end

      it 'sets the subject' do
        expect(ActionMailer::Base.deliveries.last.subject)
          .to eq("Novo contato de #{user}")
      end
    end
  end
end
