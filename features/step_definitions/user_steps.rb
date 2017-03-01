Given(/^there are users signed up with the following data:$/) do |table|
  table.hashes.each do |line|
    create :user, line
  end
end

Given(/^there is an user signed up with the following data:$/) do |table|
  step 'there are users signed up with the following data:', table
end

Given(/^I am signed up with the following data:$/) do |table|
  @user = create :user, table.hashes.first
end

Given(/^there is an user called "(.*?)"$/) do |name|
  create :user, name: name
end

Given(/^"(.*?)" is blocked$/) do |user_name|
  user = User.find_by(name: user_name)

  user.state = 'blocked'

  user.save!
end
