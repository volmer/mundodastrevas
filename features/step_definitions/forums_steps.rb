Given(/^there is a topic called "(.*?)" in the "(.*?)" forum$/) do |topic_name, forum_name|
  forum = Raddar::Forums::Forum.find_by(name: forum_name) || create(:forum, name: forum_name)
  create(:topic, forum: forum, name: topic_name)
end

Given(/^there is a post "(.*?)" in the "(.*?)" topic$/) do |content, topic_name|
  topic = Raddar::Forums::Topic.find_by(name: topic_name)

  create(:forum_post, topic: topic, content: content)
end

When(/^I go to the "(.*?)" forum$/) do |forum_name|
  forum = Raddar::Forums::Forum.find_by(name: forum_name) || create(:forum, name: forum_name)

  visit raddar_forums.forum_path(forum)
end
