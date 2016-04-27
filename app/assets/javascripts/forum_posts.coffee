window.Forums = window.Forums || {}

Forums.editPost = ($post) ->
  Forums.cancelEditPost()
  $post.find('.post').hide()
  $post.find('.editor').removeAttr('hidden')

Forums.cancelEditPost = ($post) ->
  $('.forum-post .editor').attr('hidden', true)
  $('.forum-post .post').show()

$ ->
  $('.forum-post a[href="#edit"]').click ->
    Forums.editPost($(this).parents('.forum-post'))

  $('.forum-post a[href="#cancel"]').click ->
    Forums.cancelEditPost()
