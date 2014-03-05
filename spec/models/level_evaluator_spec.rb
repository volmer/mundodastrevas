require 'spec_helper'

describe LevelEvaluator do
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

  describe '#scopre' do
    it 'is 0 when user has no contribution' do
      expect(calculator.score).to eq(0)
    end

    it 'increases 1 point for each forum post published' do
      expect {
        create_list(:post, 3, user: user, universe: universe)
      }.to change { calculator.score }.by(3)
    end

    it 'increases 3 points for each zine post published' do
      expect {
        create_list(:zine_post, 2, user: user, universe: universe)
      }.to change { calculator.score }.by(6)
    end

    it 'increases 1 point for each comment published' do
      expect {
        create_list(:comment, 4, user: user, universe: universe)
      }.to change { calculator.score }.by(4)
    end

    context 'with relevant records' do
      before do
        allow(calculator).to receive(:relevant?).and_return(true)
      end

      it 'increases 2 points for each relevant forum post published' do
        expect {
          create_list(:post, 3, user: user, universe: universe)
        }.to change { calculator.score }.by(6)
      end

      it 'increases 6 points for each relevant zine post published' do
        expect {
          create_list(:zine_post, 2, user: user, universe: universe)
        }.to change { calculator.score }.by(12)
      end

      it 'increases 2 point for each relevant comment published' do
        expect {
          create_list(:comment, 4, user: user, universe: universe)
        }.to change { calculator.score }.by(8)
      end
    end
  end

  describe '#to_next_level' do
    it 'returns 7 if user is level 1 and it has 0 points' do
      allow(user).to receive_message_chain(:rank_in, :value).and_return(1)
      allow(calculator).to receive(:score).and_return(0)

      expect(calculator.to_next_level).to eq(7)
    end

    it 'returns 3 if user is level 1 and it has 4 points' do
      allow(user).to receive_message_chain(:rank_in, :value).and_return(1)
      allow(calculator).to receive(:score).and_return(4)

      expect(calculator.to_next_level).to eq(3)
    end

    it 'returns 0 if user is level 1 and it has 7 points' do
      allow(user).to receive_message_chain(:rank_in, :value).and_return(1)
      allow(calculator).to receive(:score).and_return(7)

      expect(calculator.to_next_level).to eq(0)
    end

    it 'returns 10 if user is level 2 and it has 7 points' do
      allow(user).to receive_message_chain(:rank_in, :value).and_return(2)
      allow(calculator).to receive(:score).and_return(7)

      expect(calculator.to_next_level).to eq(10)
    end

    it 'returns 5 if user is level 2 and it has 12 points' do
      allow(user).to receive_message_chain(:rank_in, :value).and_return(2)
      allow(calculator).to receive(:score).and_return(12)

      expect(calculator.to_next_level).to eq(5)
    end

    it 'returns 15 if user is level 3 and it has 17 points' do
      allow(user).to receive_message_chain(:rank_in, :value).and_return(3)
      allow(calculator).to receive(:score).and_return(17)

      expect(calculator.to_next_level).to eq(15)
    end

    # This example ensures 0 for cases when the user has more points
    # than the necessary to pass to the next level.
    it 'returns 0 if user is level 3 and it has 50 points' do
      allow(user).to receive_message_chain(:rank_in, :value).and_return(3)
      allow(calculator).to receive(:score).and_return(50)

      expect(calculator.to_next_level).to eq(0)
    end

    it 'returns 23 if user is level 4 and it has 32 points' do
      allow(user).to receive_message_chain(:rank_in, :value).and_return(4)
      allow(calculator).to receive(:score).and_return(32)

      expect(calculator.to_next_level).to eq(23)
    end

    it 'returns 35 if user is level 5 and it has 55 points' do
      allow(user).to receive_message_chain(:rank_in, :value).and_return(5)
      allow(calculator).to receive(:score).and_return(55)

      expect(calculator.to_next_level).to eq(35)
    end
  end

  describe '#can_level_up?' do
    it 'returns false when user is not active' do
      user.state = 'blocked'
      allow(calculator).to receive(:to_next_level).and_return(0)
      create(:rank, value: 2, universe: universe)

      expect(calculator.can_level_up?).to be false
    end

    it 'returns false if there are still some required points left' do
      allow(calculator).to receive(:to_next_level).and_return(3)
      create(:rank, value: 2, universe: universe)

      expect(calculator.can_level_up?).to be false
    end

    it 'returns false if there is not a rank associated to the next level' do
      allow(calculator).to receive(:to_next_level).and_return(0)

      expect(calculator.can_level_up?).to be false
    end

    it 'returns true if user is active, there is no required points left and
      there is a rank associated to the next level' do
      allow(calculator).to receive(:to_next_level).and_return(0)
      create(:rank, value: 2, universe: universe)

      expect(calculator.can_level_up?).to be true
    end
  end
end
