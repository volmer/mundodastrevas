require 'rails_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  before(:all) do
    described_class.enable_processing = true
    @uploader = described_class.new(build(:universe), :image)
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
    it 'has the exact dimensions 400 by 200 pixels' do
      expect(@uploader.medium).to have_dimensions(400, 200)
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

  it 'is an Image Uploader' do
    expect(@uploader).to be_an(Raddar::ImageUploader)
  end

  describe '#default_url' do
    subject { described_class.new(build(:universe), :image) }

    it 'returns the proper fallback image' do
      expect(subject.thumb.url).to include('fallback/universe/thumb.png')
    end
  end
end
