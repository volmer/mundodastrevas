Given(/^there is a forum post "(.*?)" in the "(.*?)" topic$/) do |content, name|
  topic = Topic.find_by(name: name)

  create(:forum_post, topic: topic, content: content)
end

Given(/^there are (\d+) forum posts in the "(.*?)" topic$/) do |count, name|
  topic = Topic.find_by(name: name)
  create_list(:forum_post, count.to_i, topic: topic)
end

Given(/^I've posted "(.*?)" in the "(.*?)" topic$/) do |content, topic_name|
  topic = Topic.find_by(name: topic_name)

  create(:forum_post, topic: topic, content: content, user: @user)
end

When(/^within my forum post I click on "(.*?)"$/) do |link|
  within('.forum-post') do
    click_on link
  end
end

When(/^within the forum post I click on "(.*?)"$/) do |link|
  within('.forum-post') do
    click_on link
  end
end

Then(/^I see (\d+) forum posts$/) do |count|
  expect(page).to have_selector('.forum-post', count: count)
end
