markNotificationsAsRead = ->
  $('.notification.unread:visible').each ->
    id = $(@).data 'id'

    $.ajax
      url: "/notifications/#{ id }/read"
      type: 'PATCH'

$ ->
  markNotificationsAsRead()

  $('#notifications-menu').parent('.dropdown').on 'shown.bs.dropdown', ->
    markNotificationsAsRead()

