require 'rails_helper'

describe Comment do
  subject { build(:comment) }

  describe '#to_s' do
    it 'describes the author and post' do
      expect(subject.to_s).to eq(
        "Comentário de #{subject.user} em #{subject.post}"
      )
    end
  end
end
