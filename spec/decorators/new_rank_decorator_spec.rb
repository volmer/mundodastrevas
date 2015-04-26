require 'rails_helper'

describe Notifications::NewRankDecorator, type: :decorator do
  let(:rank) { create(:rank, universe: universe, name: 'Ancila') }
  let(:universe) { create(:universe, name: 'Vampire: the Requiem', slug: 'vampire') }
  let(:notification) { build(:notification, notifiable: rank) }
  subject(:presenter) { described_class.new(notification) }

  describe '#redirect_path' do
    subject { presenter.redirect_path }

    it 'returns the path to the post topic' do
      expect(subject).to match('/universes/vampire#tab-ranks')
    end
  end

  describe '#text' do
    subject { presenter.text }

    it 'includes the proper text' do
      expect(subject).to include('Parabéns! Agora você é um Ancila em Vampire: the Requiem!')
    end
  end

  describe '#mailer_subject' do
    subject { presenter.mailer_subject }

    it 'returns the proper text' do
      expect(subject).to eq('Parabéns, agora você é um Ancila!')
    end
  end
end
