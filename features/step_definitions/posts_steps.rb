Given(/^there is a post with the given attributes:$/) do |table|
  table.hashes.each do |line|
    create :post, line
  end
end

Given(/^there is a post called "(.*?)"$/) do |name|
  create(:post, name: name)
end

Given(/^I have a post called "(.*?)"$/) do |name|
  create(:post, user: @user, name: name)
end

Given(/^within "(.*?)" there is a post called "(.*?)"$/) do |name, post_name|
  zine = Zine.find_by(name: name)

  create(:post, zine: zine, name: post_name)
end

Given(/^I'm on the "(.*?)" post page$/) do |name|
  post = Post.find_by(name: name)

  visit zine_post_path(post.zine, post)
end

Given(/^I'm on the new post page$/) do
  zine = create(:zine, user: @user)

  visit new_zine_post_path(zine)
end

Given(/^I'm on the edit post page$/) do
  post = create(:post, user: @user)

  visit edit_zine_post_path(post.zine, post)
end

Given(/^within the zine "(.*?)" there is a post with:$/) do |name, table|
  zine = Zine.find_by(name: name)

  table.hashes.each do |line|
    create :post, line.merge(zine: zine)
  end
end

Given(/^the zine "(.*?)" has (\d+) posts$/) do |name, count|
  zine = Zine.find_by(name: name)

  create_list(:post, count.to_i, zine: zine)
end

Given(/^I am watching the post "(.*?)"$/) do |name|
  post = Post.find_by(name: name)

  post.watches.create!(user: @user)
end

When(/^I go to the "(.*?)" post$/) do |name|
  post = Post.find_by(name: name)

  visit zine_post_path(post.zine, post)
end

Then(/^I see (\d+) posts$/) do |count|
  expect(page).to have_selector('.post-list-item', count: count)
end
