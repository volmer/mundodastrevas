Given(/^there is a forum called "(.*?)"$/) do |name|
  create :forum, name: name
end

Given(/^there is a forum with the given attributes:$/) do |table|
  table.hashes.each do |line|
    create :forum, line
  end
end

Given(/^I am following the "(.*?)" forum$/) do |forum_name|
  followership = Raddar::Followership.new
  followership.user = @user
  followership.followable = Forum.find_by(name: forum_name)
  followership.save!
end


When(/^I go to the "(.*?)" forum$/) do |forum_name|
  forum = Forum.find_by(name: forum_name) || create(:forum, name: forum_name)

  visit forum_path(forum)
end

Then(/^I am redirected to "(.*?)" forum$/) do |forum_name|
  forum = Forum.find_by(name: forum_name)

  expect(current_path).to eq forum_path(forum)
end