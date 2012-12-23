models = [
  'blog',
  'user'
]

init = (db) ->
  require("./#{model}").init(db) for model in models

exports.init = init
