require 'rails_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  before(:all) do
    described_class.enable_processing = true
    @user = create(:user)
    @uploader = described_class.new(@user, :avatar)
    @uploader.store!(File.open(Rails.root.to_s + '/spec/fixtures/image.jpg'))
  end

  after(:all) do
    described_class.enable_processing = false
    @uploader.remove!
  end

  context 'the original version' do
    it 'scales down a landscape image to fit within 760 by 1160 pixels' do
      expect(@uploader).to be_no_larger_than(760, 1160)
    end
  end

  context 'the medium version' do
    it 'has the exact dimensions 360 by 360 pixels' do
      expect(@uploader.medium).to have_dimensions(360, 360)
    end
  end

  context 'the small version' do
    it 'has the exact dimensions 160 by 160 pixels' do
      expect(@uploader.small).to have_dimensions(160, 160)
    end
  end

  context 'the thumb version' do
    it 'has the exact dimensions 60 by 60 pixels' do
      expect(@uploader.thumb).to have_dimensions(60, 60)
    end
  end

  it 'makes the image readable and not executable' do
    expect(@uploader).to have_permissions(0666)
  end

  describe '#default_url' do
    it 'returns the proper fallback image' do
      expect(@uploader.default_url).to eq('/assets/fallback/user/original.png')
    end
  end

  describe '#store_dir' do
    it 'properly stores uploads according to the model class and id' do
      expect(@uploader.store_dir).to eq("uploads/user/#{@user.id}/avatar")
    end
  end

  describe '#extension_white_list' do
    subject { @uploader.extension_white_list }

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
