Given(/^there is a comment "(.*?)" in the "(.*?)" post$/) do |content, name|
  post = Post.find_by(name: name)

  create(:comment, post: post, content: content)
end

Given(/^I've commented "(.*?)" in the "(.*?)" post$/) do |content, post_name|
  post = Post.find_by(name: post_name)

  create(:comment, post: post, content: content, user: @user)
end

Given(/^davos wrote a new comment on the post "(.*?)"$/) do |post_name|
  watcher = @user

  step('I am signed in as "davos"')
  step("I go to the \"#{post_name}\" post")
  step('I fill in "comment_content" with "My comment"')
  step('I click on "Comentar"')

  step("I am signed in as \"#{watcher}\"")
end

When(/^within my comment I click on "(.*?)"$/) do |link|
  within('.comment') do
    click_on link
  end
end
