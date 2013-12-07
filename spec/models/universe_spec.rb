require 'spec_helper'

describe Universe do
  it { should have_many(:forums).class_name('Raddar::Forums::Forum').dependent(:nullify) }
  it { should have_many(:zines).class_name('Raddar::Zines::Zine').dependent(:nullify) }

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(100) }

  it { should validate_presence_of(:description) }
  it { should ensure_length_of(:description).is_at_most(6_000) }

  it { should validate_presence_of(:slug) }
  it { should validate_uniqueness_of(:slug).case_insensitive }
  it { should ensure_length_of(:slug).is_at_least(3).is_at_most(100) }

  it { should allow_value('game').for(:slug) }
  it { should allow_value('ga-me').for(:slug) }
  it { should allow_value('GAME').for(:slug) }
  it { should allow_value('game123').for(:slug) }
  it { should_not allow_value('ga_me').for(:slug) }
  it { should_not allow_value('game!').for(:slug) }

  it 'is a Bootsy container' do
    expect(subject).to be_a_kind_of(Bootsy::Container)
  end

  describe '#to_param' do
    it 'returns its slug' do
      subject.slug = 'werewolf-the-forsaken'

      expect(subject.to_param).to eq('werewolf-the-forsaken')
    end
  end

  describe '#to_s' do
    it 'returns its name' do
      subject.name = 'Werewolf: the Forsaken'

      expect(subject.to_s).to eq('Werewolf: the Forsaken')
    end
  end

  describe '#image' do
    it 'is an uploader field' do
      expect(subject.image).to be_an_instance_of(ImageUploader)
    end
  end
end
