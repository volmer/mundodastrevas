require 'rails_helper'

describe Notifications::NewForumPostDecorator, type: :decorator do
  let(:user) { create(:user, name: 'khaldrogo') }

  let(:forum_post) { create(:forum_post, user: user, topic: topic) }

  let(:topic) { create(:topic, name: 'The Dothraki Sea') }

  let(:notification) do
    build(:notification, notifiable: forum_post, event: 'new_forum_post')
  end

  subject(:presenter) { described_class.new(notification) }

  describe '#redirect_path' do
    subject { presenter.redirect_path }

    it 'returns the path to the post topic' do
      expect(subject).to match(%r{forums/(.*?)/topics/(.*?)the-dothraki-sea})
    end

    it 'includes the last page number in path when there are multiple pages' do
      create_list(:forum_post, 22, topic: topic)

      expect(subject).to include('?page=3')
    end
  end

  describe '#text' do
    subject { presenter.text }

    it 'includes the proper text' do
      expect(subject).to include('khaldrogo postou em The Dothraki Sea.')
    end
  end

  describe '#mailer_subject' do
    subject { presenter.mailer_subject }

    it 'returns the proper text' do
      expect(subject).to eq('Nova postagem em The Dothraki Sea')
    end
  end
end
