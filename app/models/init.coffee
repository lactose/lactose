fs = require 'fs'
models = fs.readdirSync __dirname

init = (db) ->
  require("./#{model}").init(db) for model in models when model isnt 'init.coffee'

exports.init = init
