require 'rails_helper'

describe Zine do
  subject { build(:zine) }

  describe 'associations' do
    it { is_expected.to belong_to(:user)}
    it { is_expected.to have_many(:followers).class_name('Followership').dependent(:destroy) }
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_one(:activity).class_name('Activity').dependent(:destroy) }
    it { is_expected.to belong_to(:universe) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to ensure_length_of(:name).is_at_most(100) }

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to ensure_length_of(:description).is_at_most(66_000) }

    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }
    it { is_expected.to ensure_length_of(:slug).is_at_least(3).is_at_most(100) }

    it { is_expected.to allow_value('game').for(:slug) }
    it { is_expected.to allow_value('ga-me').for(:slug) }
    it { is_expected.to allow_value('GAME').for(:slug) }
    it { is_expected.to allow_value('game123').for(:slug) }
    it { is_expected.not_to allow_value('ga_me').for(:slug) }
    it { is_expected.not_to allow_value('game!').for(:slug) }

    it { is_expected.to validate_presence_of(:user_id) }
  end

  it 'is a Bootsy container' do
    expect(subject).to be_a_kind_of(Bootsy::Container)
  end

  describe '#to_param' do
    it 'returns its slug' do
      subject.slug = 'a-song-of-ice-and-fire'

      expect(subject.to_param).to eq('a-song-of-ice-and-fire')
    end
  end

  describe '#to_s' do
    it 'returns its name' do
      subject.name = 'A Song of Ice and Fire'

      expect(subject.to_s).to eq('A Song of Ice and Fire')
    end
  end

  describe '#image' do
    it 'is an uploader field' do
      expect(subject.image).to be_an_instance_of(ImageUploader)
    end
  end

  describe '.with_posts' do
    subject { described_class.with_posts }

    it 'returns zines that have at least one post' do
      zine_with_post = create(:zine)
      create(:post, zine: zine_with_post)
      zine_without_post = create(:zine)

      expect(subject).to include(zine_with_post)
      expect(subject).not_to include(zine_without_post)
    end

    it 'returns one record per zine with posts' do
      zine_with_post = create(:zine)
      create_list(:post, 3, zine: zine_with_post)

      expect(subject.count).to eq(1)
    end
  end

  context 'when a record is created' do
    subject! { build(:zine) }

    it 'creates an activity' do
      expect {
        subject.save
      }.to change{
        Activity.count
      }.by(1)

      activity = Activity.last

      expect(activity.user).to eq(subject.user)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('zines.create')
      expect(activity.privacy).to eq('public')
    end
  end
end
