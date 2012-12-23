db = null
files = null
fs = require 'fs'
protect =
  'admin':true
  'authorized':false

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

  if "#{controller}.coffee" in files
    recipient = require __dirname + '/' + controller
  else
    return error(req, res, next, db)

  if protect[controller] and !req.loggedIn
    login(req, res, next, db)
  else if typeof recipient[action] == 'function' 
    recipient[action](req, res, next, db) 
  else
    error(req, res, next, db)

error = (req, res, next, db) ->
  options =
    title: '404'
  res.render 'error', options

login = (req, res, next, db) ->
  options =
    title: 'login'
  res.render 'login', options
