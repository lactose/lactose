months = [ 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'November', 'December' ]

getNiceDate = (date) ->
  nice = "#{months[date.getMonth()]} #{pluralize(date.getDate(), date.getDate())}, #{date.getFullYear()}"

pluralize = (string, number) ->
  pluralized = ""
  switch number
    when 1
      pluralized = "#{string}st"
    when 2
      pluralized = "#{string}nd"
    else
      pluralized = "#{string}th"
  pluralized

exports.getNiceDate = getNiceDate
