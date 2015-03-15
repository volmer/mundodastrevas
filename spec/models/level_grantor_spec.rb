require 'rails_helper'

describe LevelGrantor do
  describe '#level_up!' do
    let(:user) { create(:user) }
    let(:universe) { create(:universe) }
    subject { described_class.level_up!(user, universe) }

    context 'when user can level up' do
      before do
        # With a score of 10, the user can level up from 1 to 2
        allow_any_instance_of(LevelEvaluator).to receive(:score).and_return(10)

        # Also, there must be a rank to the next level
        create(:rank, universe: universe, value: 2)
      end

      it 'upgrades the user rank in the universe' do
        create(:rank, universe: universe, value: 1)

        expect {
          subject
        }.to change {
          user.rank_in(universe).value
        }.from(1).to(2)
      end

      it 'returns the level with its value upgraded' do
        expect(subject.value).to eq 2
      end

      it 'schedules a notification job with proper arguments' do
        rank = subject.rank

        job = RankNotificationJob.queue_adapter.enqueued_jobs.last

        expect(job[:args]).to eq([user, rank])
      end
    end

    it 'returns nil when user cannot level up' do
      expect(subject).to be_nil
    end
  end
end
