desc 'This is the default task.'
task 'default', (params) ->
  cmds = [
    'coffee -o ./public/javascripts/ -c ./app/assets/javascripts/',
    'node ./boot.js'
  ]
  jake.exec cmds, ->
    console.log "opened boot.js with Jake"
    complete()
  , printStdout: true
