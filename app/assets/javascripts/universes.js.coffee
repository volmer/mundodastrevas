$ ->
  # Javascript to enable link to tab
  hash = document.location.hash
  prefix = 'tab-'

  if hash
    $(".universe-nav a[href='#{ hash.replace(prefix, '') }']").tab('show')

  # Change hash for page-reload
  $('.universe-nav a').on 'shown.bs.tab', (e)->
    window.location.hash = e.target.hash.replace('#', '#' + prefix)
