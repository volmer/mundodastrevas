require 'spec_helper'

describe LevelsCalculator do
  let(:user) { create(:user) }
  let(:universe) { create(:universe) }
  subject(:calculator) { described_class.new(user, universe) }

  describe '#relevant?' do
    subject { calculator.relevant?(reviewable) }
    let(:reviewable) { create(:post) }

    context 'the given reviewable has received at least 3 reviews' do
      before { create_list(:review, 3, reviewable: reviewable) }

      it 'is true when the given reviewable has more positive than negative reviews' do
        create_list(:review, 4, reviewable: reviewable, value: 'loved')

        expect(subject).to be true
      end

      it 'is false otherwise' do
        create_list(:review, 3, reviewable: reviewable, value: 'hated')

        expect(subject).to be false
      end
    end

    context 'the given reviewable has less than 3 reviews' do
      before { create_list(:review, 2, reviewable: reviewable) }

      it 'is false' do
        expect(subject).to be false
      end
    end
  end

  describe '#points' do
    it 'is 0 when user has no contribution' do
      expect(calculator.points).to eq(0)
    end

    it 'increases 1 point for each forum post published' do
      expect {
        create_list(:post, 3, user: user, universe: universe)
      }.to change { calculator.points }.by(3)
    end

    it 'increases 3 points for each zine post published' do
      expect {
        create_list(:zine_post, 2, user: user, universe: universe)
      }.to change { calculator.points }.by(6)
    end

    it 'increases 1 point for each comment published' do
      expect {
        create_list(:comment, 4, user: user, universe: universe)
      }.to change { calculator.points }.by(4)
    end

    context 'with relevant records' do
      before do
        allow(calculator).to receive(:relevant?).and_return(true)
      end

      it 'increases 2 points for each relevant forum post published' do
        expect {
          create_list(:post, 3, user: user, universe: universe)
        }.to change { calculator.points }.by(6)
      end

      it 'increases 6 points for each relevant zine post published' do
        expect {
          create_list(:zine_post, 2, user: user, universe: universe)
        }.to change { calculator.points }.by(12)
      end

      it 'increases 2 point for each relevant comment published' do
        expect {
          create_list(:comment, 4, user: user, universe: universe)
        }.to change { calculator.points }.by(8)
      end
    end
  end

  describe '#level' do
    subject { calculator.level }

    it 'returns 1 if points are lower than 7' do
      allow(calculator).to receive(:points).and_return(6)

      expect(calculator.level).to eq(1)
    end

    it 'returns 2 if points are 7' do
      allow(calculator).to receive(:points).and_return(7)

      expect(calculator.level).to eq(2)
    end

    it 'returns 3 if points are 17' do
      allow(calculator).to receive(:points).and_return(17)

      expect(calculator.level).to eq(3)
    end

    it 'returns 4 if points are 32' do
      allow(calculator).to receive(:points).and_return(32)

      expect(calculator.level).to eq(4)
    end

    it 'returns 5 if points are 55' do
      allow(calculator).to receive(:points).and_return(55)

      expect(calculator.level).to eq(5)
    end

    it 'returns 6 if points are 90' do
      allow(calculator).to receive(:points).and_return(90)

      expect(calculator.level).to eq(6)
    end
  end

  describe '#grant' do
    context 'when user is active' do


    end

    context 'when user is not active' do
      before { user.state = 'blocked' }

      it 'returns nil' do
        expect(calculator.grant).to be_nil
      end
    end
  end
end
