Given(/^there is a topic called "(.*?)" in "(.*?)"$/) do |name, forum_name|
  forum = Forum.find_by(name: forum_name) || create(:forum, name: forum_name)
  create(:topic, forum: forum, name: name)
end

Given(/^I've created a topic called "(.*?)" in "(.*?)"$/) do |name, forum_name|
  forum = Forum.find_by(name: forum_name) || create(:forum, name: forum_name)
  create(:topic, forum: forum, name: name, user: @user)
end

Given(/^there are (\d+) topics on the "(.*?)" forum$/) do |count, forum_name|
  forum = Forum.find_by(name: forum_name) || create(:forum, name: forum_name)
  create_list(:topic, count.to_i, forum: forum)
end

Given(/^I am watching the topic "(.*?)"$/) do |topic_name|
  topic = Topic.find_by(name: topic_name)

  topic.watches.create!(user: @user)
end

Given(/^davos wrote a new post on the topic "(.*?)"$/) do |topic_name|
  topic = Topic.find_by(name: topic_name)

  watcher = @user

  step('I am signed in as "davos"')
  step("I go to the \"#{topic.forum.name}\" forum")
  step("I click on \"#{topic_name}\"")
  step('I fill in "forum_post_content" with "My post"')
  step('I click on "Postar"')

  step("I am signed in as \"#{watcher}\"")
end

Then(/^I see (\d+) topics$/) do |count|
  expect(page).to have_selector('tr.topic', count: count)
end
