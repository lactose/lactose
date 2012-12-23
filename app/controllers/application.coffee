db = null
protect =
  'admin':true
  'authorized':false

module.exports = (app, database, params) ->
  db = database
  app.get '/', router
  app.all '/:controller?', router
  app.all '/:controller/:action?', router
  app.all '/:controller/:action/:id?', router

router = (req, res, next) ->
  controller = if req.params.controller then req.params.controller else ''
  action = if req.params.action then req.params.action else 'default'
  id = if req.params.id then req.params.id else null

  recipient = require __dirname + '/' + controller.toLowerCase()
  if typeof recipient[action] == 'function' 
    recipient[action](req, res, next, db) 
  else
    index(req, res, next, db)

index = (req, res, next, db) ->
  options =
    title: 'test'
  res.render 'index', options
