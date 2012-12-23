http      = require "http"
fs        = require "fs"
appConfig = JSON.parse fs.readFileSync(__dirname + '/config/app.json', 'UTF-8')
cluster   = require "cluster"
numCPUs   = require("os").cpus().length
mongo     = require "mongodb"
models    = require "./app/models/init"
db        = new mongo.Db appConfig.db.name, new mongo.Server(appConfig.db.host, appConfig.db.port, appConfig.db.options)

init = ->
  appConfig.boot.path = __dirname
  models.init(db) # initialize database collections
  app = require("./app").boot(db, appConfig.boot) # boot the applaction

  # start the workers if in production mode
  if cluster.isMaster && process.env.NODE_ENV == 'production'
    cluster.fork() for worker in [numCPUs..1]
  else
    server = http.createServer(app).listen app.get('port'), ->
      console.log "server created at #{app.get('port')}"

db.open (err, db) ->
  init() unless err

