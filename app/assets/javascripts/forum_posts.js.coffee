window.Raddar = window.Raddar || {}
window.Raddar.Forums = window.Raddar.Forums || {}

Raddar.Forums.editPost = ($post) ->
  Raddar.Forums.cancelEditPost()
  $post.find('.post').hide()
  $post.find('.editor').removeClass('hide')

Raddar.Forums.cancelEditPost = ($post) ->
  $('.forum-post .editor').addClass('hide')
  $('.forum-post .post').show()

Raddar.Forums.quotePost = ($post) ->
  content    = $.trim($post.find('.content').text())
  author     = $post.find('.user .name').html()

  blockquote =  """
                <blockquote>
                  <p>#{ content }</p>

                  <small>#{ author }</small>
                </blockquote>

                <br/>
                """

  Bootsy.areas.forum_post_content.editor.focus()
  Bootsy.areas.forum_post_content.editor.composer.commands.exec('insertHTML', blockquote)

$ ->
  $('.forum-post a[href="#edit"]').click ->
    Raddar.Forums.editPost($(this).parents('.forum-post'))

  $('.forum-post a[href="#cancel"]').click ->
    Raddar.Forums.cancelEditPost()

  $('.forum-post a[href="#quote"]').click ->
    Raddar.Forums.quotePost($(this).parents('.forum-post'))
