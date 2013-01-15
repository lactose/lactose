replaceContent = (options) ->
  settings =
    success: (result) ->
      $('section').hide 'slide', {direction: 'left' }, 'swing', ->
        $(this).replaceWith($(result).find('section').hide())
        $('section').show 'slide', {direction: 'right', 'swing'}
  settings = $.extend(options, settings)
  $.ajax settings

$('.post--load').on 'click', (e) ->
  e.preventDefault()
  url = $(this).attr 'href'
  settings =
    url: url
    dataType: 'html'

  replaceContent settings

