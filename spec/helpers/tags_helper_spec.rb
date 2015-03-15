require 'rails_helper'

describe Raddar::TagsHelper, type: :helper do
  let(:taggable) { create(:post) }

  describe '#render_tags' do
    subject { helper.render_tags(taggable) }

    it 'includes a link for each tag in the given taggable' do
      create(:tagging, tag: create(:tag, name: 'ancient'), taggable: taggable)
      create(:tagging, tag: create(:tag, name: 'gothic'), taggable: taggable)

      expect(subject).to include('href="/tags/ancient"')
      expect(subject).to include('href="/tags/gothic"')
    end
  end
end
