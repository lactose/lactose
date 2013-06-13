replaceContent = (options) ->
  settings =
    success: (result) ->
      $newContent = $(result).find('section').hide()
      $('section').hide 'slide', {direction: 'left' }, 'swing', ->
        $(this).replaceWith($newContent)
        $newContent.show 'slide', {direction: 'right', 'swing'}
        Linc.run '.widgets', {context: $newContent}
  settings = $.extend(options, settings)
  $.ajax settings

Linc.add 'clickBindings.widgets', ->
  $('.ajax').on 'click', (e) ->
    e.preventDefault()
    url = $(this).attr 'href'
    settings =
      url: url
      dataType: 'html'

    replaceContent settings

    #Linc.run('.widgets')
