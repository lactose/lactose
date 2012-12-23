express = require "express"

boot = (db, params) ->
  app = express()
  config = require(__dirname + "/config/environment")(app, db, params, express)
  controller = require(__dirname + '/app/controllers/application')(app, db, params)
  return app

exports.boot = boot
