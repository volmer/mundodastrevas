require 'rails_helper'

describe 'Search', type: :feature, js: true do
  before { visit root_path }

  it 'works simultaneously on multiple types of content' do
    pending
    create(:user, name: 'sansa_stark')
    create(:page, title: 'Stark Family')
    create(:zine, name: 'Book of Starks')
    create(:post, name: 'Ned Stark is dead')
    create(:forum, name: 'The Starks')
    create(:topic, name: 'Who is your favorite Stark?')
    forum_post = create(:forum_post, content: 'Arya Stark!')
    Elasticsearch::Model.client.indices.refresh

    fill_in 'q', with: 'stark'
    find_field('q').native.send_keys(:return)

    expect(page).to have_link('sansa_stark')
    expect(page).to have_link('Stark Family')
    expect(page).to have_link('Book of Starks')
    expect(page).to have_link('Ned Stark is dead')
    expect(page).to have_link('Who is your favorite Stark?')
    expect(page).to have_link(forum_post.topic.name)
  end

  it 'paginates the results' do
    pending
    create_list(:page, 22, title: 'Stark Family')
    Elasticsearch::Model.client.indices.refresh

    fill_in 'q', with: 'stark'
    find_field('q').native.send_keys(:return)

    expect(all('.pagination .page a').last).to eq '3'
    expect(page).to have_selector('.search-result', count: 10)

    within('.pagination') { click_on '3' }
    expect(page).to have_selector('.search-result', count: 2)
  end
end
