db = null

init = (dbase) ->
  db = dbase
  db.user = db.collection 'user'
exports.init = init
