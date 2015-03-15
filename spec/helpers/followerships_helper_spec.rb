require 'rails_helper'

describe Raddar::FollowershipsHelper, type: :helper do
  before { helper.extend(Raddar::Engine.routes.url_helpers) }

  describe '#follow_link' do
    let(:followable) { create(:user, name: 'followableuser') }

    subject { helper.follow_link(followable, current_user) }

    context 'when user is signed in' do
      let(:current_user) { create(:user) }

      context 'when user is not following followable' do
        it 'returns a link to create a followership' do
          expect(subject).to include('href="/users/followableuser/followerships"')

          expect(subject).to include('data-method="post"')
        end
      end

      context 'when user is already following followable' do
        before { create(:followership, user: current_user, followable: followable) }

        it 'returns a link to destroy the followership' do
          expect(subject).to include('href="/users/followableuser/followerships/')

          expect(subject).to include('data-method="delete"')
        end
      end
    end

    context 'when user is not signed in' do
      let(:current_user) { nil }

      it 'is blank' do
        expect(subject).to be_blank
      end
    end
  end

  describe '#following_count' do
    let(:user) { create(:user, name: 'followeruser') }

    subject { helper.following_count(user) }

    before { create_list(:followership, 3, user: user) }

    it 'includes the number of elements the given user is following' do
      expect(subject).to include('3')
    end

    it 'is a link to the user "following" page' do
      expect(subject).to include('href="/users/followeruser/following"')
    end
  end

  describe '#followers_count' do
    let(:user) { create(:user, name: 'followeduser') }

    subject { helper.followers_count(user) }

    before { create_list(:followership, 5, followable: user) }

    it 'includes the number of users that is following the given user' do
      expect(subject).to include('5')
    end

    it 'is a link to the user "followers" page' do
      expect(subject).to include('href="/users/followeduser/followers"')
    end
  end
end
