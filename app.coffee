express = require "express"

boot = (db, params) ->
  app = express()
  # set up the environments and express 
  config = require(__dirname + "/config/environment")(app, db, params, express)
  # start the application controller
  controller = require(__dirname + '/app/controllers/application')(app, db, params)
  return app

exports.boot = boot
