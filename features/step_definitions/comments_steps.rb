Given(/^there is a comment "(.*?)" in the "(.*?)" post$/) do |content, name|
  post = Post.find_by(name: name)

  create(:comment, post: post, content: content)
end
