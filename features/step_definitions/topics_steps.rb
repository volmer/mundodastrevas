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

Then(/^I see (\d+) topics$/) do |count|
  expect(page).to have_selector('tr.topic', count: count)
end
