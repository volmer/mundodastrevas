require 'rails_helper'

describe Raddar::ImageUploader do
  let(:user) { create(:user) }

  subject(:uploader) { described_class.new(user, :avatar) }

  describe '#store_dir' do
    it 'properly stores uploads according to the model class and id' do
      expect(subject.store_dir).to eq("uploads/raddar/user/#{user.id}/avatar")
    end
  end

  describe '#extension_white_list' do
    subject { uploader.extension_white_list }

    it 'includes png' do
      expect(subject).to include('png')
    end

    it 'includes jpg' do
      expect(subject).to include('jpg')
    end

    it 'includes gif' do
      expect(subject).to include('gif')
    end

    it 'includes jpeg' do
      expect(subject).to include('jpeg')
    end
  end
end
