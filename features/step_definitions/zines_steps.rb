Given(/^there is a zine with the given attributes:$/) do |table|
  table.hashes.each do |line|
    create :zine, line
  end
end

Given(/^I have a zine with the given attributes:$/) do |table|
  table.hashes.each do |line|
    create :zine, line.merge(user: @user)
  end
end

Given(/^I have a zine called "(.*?)"$/) do |name|
  create(:zine, user: @user, name: name)
end

Given(/^there is a zine called "(.*?)"$/) do |name|
  create :zine, name: name
end

Given(/^there are (\d+) zines$/) do |count|
  create_list(:zine, count.to_i)
end

Given(/^there are (\d+) zines with posts$/) do |count|
  create_list(:post, count.to_i)
end

Given(/^I'm on the "(.*?)" zine page$/) do |zine_name|
  step("I go to the \"#{zine_name}\" zine")
end

When(/^I go to the "(.*?)" zine$/) do |zine_name|
  zine = Zine.find_by(name: zine_name)

  visit zine_path(zine)
end

Then(/^I am redirected to "(.*?)" zine$/) do |zine_name|
  zine = Zine.find_by(name: zine_name)

  expect(current_path).to eq zine_path(zine)
end

Then(/^I see (\d+) zines$/) do |count|
  expect(page).to have_selector('.zine-list-item', count: count)
end
