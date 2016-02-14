require 'rails_helper'

describe WatchesHelper, type: :helper do
  before { allow(helper).to receive(:post_path) }
  let(:watchable) { create(:post) }
  let(:user) { create(:user) }

  describe '#watch_button' do
    subject { helper.watch_button(watchable, user) }

    context 'when user does not have a watch relation with watchable' do
      it 'includes a watch form' do
        expect(subject).to include('Vigiar')
      end
    end

    context 'when user has an active watch relation with watchable' do
      before { create(:watch, watchable: watchable, user: user, active: true) }

      it 'includes an unwatch form' do
        expect(subject).to include('Parar de vigiar')
      end
    end

    context 'when user has an inactive watch relation with watchable' do
      before { create(:watch, watchable: watchable, user: user, active: false) }

      it 'includes a watch form' do
        expect(subject).to include('Vigiar')
      end
    end

    context 'with a watchable path' do
      subject { helper.watch_button(watchable, user, '/path/to/watchable') }

      it 'includes the watchable path' do
        expect(subject).to include('/path/to/watchable')
      end
    end
  end

  describe '#fields_for_watch' do
    let(:form) do
      ActionView::Helpers::FormBuilder.new(:post, watchable, helper, {})
    end

    subject { helper.fields_for_watch(form, watchable, user) }

    context 'when user does not have a watch relation with watchable' do
      it 'includes a checked input' do
        expect(subject).to include('checked')
      end
    end

    context 'when user has an active watch relation with watchable' do
      before { create(:watch, watchable: watchable, user: user, active: true) }

      it 'includes a checked input' do
        expect(subject).to include('checked')
      end
    end

    context 'when user has an inactive watch relation with watchable' do
      before { create(:watch, watchable: watchable, user: user, active: false) }

      it 'includes a checked input' do
        expect(subject).not_to include('checked')
      end
    end

    it 'renders the default label' do
      expect(subject).to include('Notifique-me sobre este item')
    end

    context 'with a label' do
      subject do
        helper.fields_for_watch(
          form, watchable, user, 'Watch by checking here.')
      end

      it 'includes the label' do
        expect(subject).to include('Watch by checking here.')
      end
    end
  end
end
