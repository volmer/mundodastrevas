Given(/^I am watching the post$/) do
  create(:watch, user: @user, watchable: Post.last)
end

Given(/^davos has commented on the "(.*?)" post$/) do |post_name|
  watcher = @user

  step('I am signed in as "davos"')
  step("I'm on the \"#{post_name}\" post page")
  step('I fill in "comment_content" with "My comment"')
  step('I click on "Comentar"')

  step("I am signed in as \"#{ watcher }\"")
end

Then(/^I don't see any notifications$/) do
  expect(page).not_to have_selector('.notification')
end
