Given(/^the post "(.*?)" has recieved (\d+) positive reviews$/) do |name, count|
  post = Post.find_by!(name: name)
  create_list(:review, count.to_i, reviewable: post, value: 'loved')
end

Given(/^the post "(.*?)" has recieved (\d+) negative reviews$/) do |name, count|
  post = Post.find_by!(name: name)
  create_list(:review, count.to_i, reviewable: post, value: 'hated')
end

Given(/^I've reviewed the post "(.*?)" as positive$/) do |name|
  post = Post.find_by!(name: name)
  create(:review, reviewable: post, user: @user, value: 'loved')
end

Given(/^I've reviewed the post "(.*?)" as negative$/) do |name|
  post = Post.find_by!(name: name)
  create(:review, reviewable: post, user: @user, value: 'hated')
end

When(/^I check the post as "(.*?)"$/) do |value|
  within('.post') do
    find(".btn.#{value}").click
  end
end

When(/^I check the forum post as "(.*?)"$/) do |value|
  within('.forum-post') do
    find(".btn.#{value}").click
  end
end

When(/^I check the comment as "(.*?)"$/) do |value|
  find(".comment .btn.#{value}").click
end

Then(/^I see "(.*?)" in the "(.*?)" post counter$/) do |count, type|
  within('.post') do
    button = find(".btn.#{type}")

    expect(button).to have_content(count)
  end
end

Then(/^I see "(.*?)" in the "(.*?)" comment counter$/) do |count, type|
  within('.comment') do
    button = find(".btn.#{type}")

    expect(button).to have_content(count)
  end
end

Then(/^I see "(.*?)" in the "(.*?)" forum post counter$/) do |count, type|
  within('.forum-post') do
    button = find(".btn.#{type}")

    expect(button).to have_content(count)
  end
end
