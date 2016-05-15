require 'rails_helper'

describe Taggable do
  subject(:taggable) { create(:post) } # Post is taggable.

  describe '#tags' do
    subject { taggable.tags }

    context 'when tags are present' do
      before { taggable.tags = 'awesome, story' }

      it 'returns the present tag names' do
        expect(subject).to eq('awesome, story')
      end
    end

    context 'when tags are not present' do
      context 'when there are taggings' do
        before do
          create(:tagging, tag: create(:tag, name: 'nice'), taggable: taggable)
          create(
            :tagging, tag: create(:tag, name: 'chapter'), taggable: taggable
          )
        end

        it 'returns the tag names separated by comma' do
          expect(subject).to eq('chapter, nice')
        end
      end

      context 'when there are no taggings' do
        it 'is blank' do
          expect(subject).to be_blank
        end
      end
    end
  end

  describe '#tags=' do
    subject { taggable.tags = value }
    let(:value) { 'amazing' }

    context 'when the given tags are diffent from the current ones' do
      before do
        create(:tagging, tag: create(:tag, name: 'awesome'), taggable: taggable)
      end

      it 'sets the given value' do
        expect { subject }.to change { taggable.tags }.from(
          'awesome'
        ).to('amazing')
      end

      it 'marks tags as changed' do
        expect { subject }.to change { taggable.tags_changed? }.from(
          false
        ).to(true)
      end
    end

    context 'when the given tags are already present' do
      before do
        create(:tagging, tag: create(:tag, name: 'amazing'), taggable: taggable)
      end

      it 'does not mark tags as changed' do
        subject

        expect(taggable.tags_changed?).to be false
      end
    end
  end

  describe '#set_taggings' do
    subject { taggable.set_taggings }

    it 'is called after the record is saved' do
      expect(taggable).to receive(:set_taggings)

      taggable.save
    end

    context 'when tags have changed' do
      before { taggable.tags = value }

      context 'when tag names exist in tags' do
        let(:value) { 'warrior, league' }

        it 'adds one tagging for each tag' do
          subject

          expect(taggable.taggings.first.tag.name).to eq('warrior')
          expect(taggable.taggings.last.tag.name).to eq('league')
        end

        context 'when there are duplicated tag names' do
          before do
            create(
              :tagging, tag: create(:tag, name: 'league'), taggable: taggable
            )
          end

          it 'does not duplicate taggings' do
            expect { subject }.to change { taggable.taggings.count }.from(
              1
            ).to(2)
          end
        end

        context 'when taggins are not represented by tag names' do
          let(:tag) { create(:tag, name: 'archer') }
          before { create(:tagging, tag: tag, taggable: taggable) }

          it 'removes them' do
            expect { subject }.to change { tag.reload.taggings.count }.from(
              1
            ).to(0)
          end
        end
      end

      context 'when there are no tag names in tags' do
        let(:value) { '' }

        context 'if there are taggings already' do
          let(:taggable) do
            post = create(:post)
            create(:tagging, tag: create(:tag, name: 'league'), taggable: post)
            post
          end

          it 'removes all present taggings' do
            expect { subject }.to change { taggable.reload.taggings.count }
              .from(1).to(0)
          end
        end
      end
    end

    context 'when tags have not changed' do
      it 'does not change existent taggings ' do
        create(:tagging, tag: create(:tag, name: 'amazing'), taggable: taggable)

        expect { subject }.not_to change { taggable.taggings }
      end
    end
  end
end
