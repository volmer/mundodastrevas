Given(/^there is a comment "(.*?)" in the "(.*?)" post$/) do |content, name|
  post = Post.find_by(name: name)

  create(:comment, post: post, content: content)
end

Given(/^I've commented "(.*?)" in the "(.*?)" post$/) do |content, post_name|
  post = Post.find_by(name: post_name)

  create(:comment, post: post, content: content, user: @user)
end

When(/^within my comment I click on "(.*?)"$/) do |link|
  within('.comment') do
    click_on link
  end
end
