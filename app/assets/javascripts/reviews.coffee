window.Reviews = window.Reviews || {}

Reviews.init = ->
  $(document).on 'ajax:beforeSend', '.review-form', ->
    $(@).find('.btn').addClass('disabled')

  $(document).on 'ajax:complete', '.review-form', ->
    $(@).find('.btn').removeClass('disabled')

  $(document).on 'ajax:success', '.review-form', (_, data)->
    count =  $(@).find(".btn.#{ data.value } .count")
    count.html(parseInt(count.html()) + 1)

    if data.created_at != data.updated_at
      count =  $(@).find(".btn.#{ $(@).data('before-change') } .count")
      count.html(parseInt(count.html()) - 1)
    else
      $(@).attr('method', 'patch')
      $(@).attr('action', $(@).attr('action') + '/' + data.id)

    $(@).find('.btn').removeClass('disabled')

  $(document).on 'ajax:error', '.review-form', ->
    $(@).find('.btn.active').removeClass('active')
    $(@).find(".btn.#{ $(@).data('before-change') }").addClass('active')

  $(document).on 'click', '.review-form .btn', ->
    form = $(@).closest('form')
    form.data('before-change', form.find('.active input').val())

  $(document).on 'change', '.review-form .btn', ->
    form = $(@).closest('form')
    form.submit()

$(Reviews.init)
