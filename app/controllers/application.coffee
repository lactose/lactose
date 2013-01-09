db = null
files = null
fs = require 'fs'
protect =
  'authorized':false
  'admin':true
admins = [
  process.env.LACTOSE_ADMIN,
  '127.0.0.1'
]

module.exports = (app, database, params) ->
  db = database
  files = fs.readdirSync __dirname
  app.get '/', router
  app.all '/:controller?', router
  app.all '/:controller/:action?', router
  app.all '/:controller/:action/:id?', router

router = (req, res, next) ->
  controller = if req.params.controller then req.params.controller.toLowerCase() else 'index'
  action = if req.params.action then req.params.action else 'default'
  id = if req.params.id then req.params.id else null
  ip = req.connection.remoteAddress

  if "#{controller}.coffee" in files
    recipient = require __dirname + '/' + controller
  else
    return error(req, res, next, db)

  if protect[controller] and ip not in admins
    error(req, res, next, db)
  else if typeof recipient[action] == 'function'
    recipient[action](req, res, next, db)
  else
    error(req, res, next, db)

error = (req, res, next, db) ->
  options =
    title: '404'
  res.render 'error', options

