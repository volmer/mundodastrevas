require 'rails_helper'

describe Notifications::NewCommentDecorator, type: :decorator do
  let(:user) { create(:user, name: 'khaldrogo') }
  let(:comment) { create(:comment, user: user, post: post) }
  let(:post) { create(:post, name: 'The Dothraki Sea', slug: 'the-dothraki-sea') }
  let(:notification) { build(:notification, notifiable: comment, event: 'new_comment') }

  subject { described_class.new(notification) }

  describe '#redirect_path' do
    it 'returns the path to the post topic' do
      expect(subject.redirect_path)
        .to match(/zines\/(.*?)\/posts\/the-dothraki-sea/)
    end
  end

  describe '#text' do
    it 'includes the proper text' do
      expect(subject.text)
        .to include('khaldrogo comentou em The Dothraki Sea.')
    end
  end

  describe '#mailer_subject' do
    it 'returns the proper text' do
      expect(subject.mailer_subject)
        .to eq('Novo comentário em The Dothraki Sea')
    end
  end
end
