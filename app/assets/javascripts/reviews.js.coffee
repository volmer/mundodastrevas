window.Raddar = window.Raddar || {}

Raddar.Reviews = Raddar.Reviews || {}

Raddar.Reviews.init = ->
  $(document).on 'ajax:beforeSend', 'form.raddar-ratings-review', ->
    $(@).find('.btn').addClass('disabled')

  $(document).on 'ajax:complete', 'form.raddar-ratings-review', ->
    $(@).find('.btn').removeClass('disabled')

  $(document).on 'ajax:success', 'form.raddar-ratings-review', (_, data)->
    count =  $(@).find(".btn.#{ data.value } .count")
    count.html(parseInt(count.html()) + 1)

    if data.created_at != data.updated_at
      count =  $(@).find(".btn.#{ $(@).data('before-change') } .count")
      count.html(parseInt(count.html()) - 1)
    else
      $(@).attr('method', 'patch')
      $(@).attr('action', $(@).attr('action') + data.id)

    $(@).find('.btn').removeClass('disabled')

  $(document).on 'ajax:error', 'form.raddar-ratings-review', ->
    $(@).find('.btn.active').removeClass('active')
    $(@).find(".btn.#{ $(@).data('before-change') }").addClass('active')

  $(document).on 'click', 'form.raddar-ratings-review .btn', ->
    form = $(@).closest('form')
    form.data('before-change', form.find('.active input').val())

  $(document).on 'change', 'input[type="radio"][name="review[value]"]', ->
    form = $(@).closest('form')

    form.submit()

$ ->
  Raddar.Reviews.init()
