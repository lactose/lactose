RedisStore = null
path    = require 'path'
redis   = require 'redis'

module.exports = (app, db, params, express) ->
  initRedis(express)
  app.configure ->
    app.set 'port', process.env.PORT || 3000
    app.set 'views', params.path + '/app/views'
    app.set 'view engine', 'jade'
    app.use express.favicon()
    app.use express.logger('dev')
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser('your secret here')
    app.use express.session({ secret: 'plop', store: new RedisStore() })
    app.use require('less-middleware')({ src: params.path + '/public' })
    app.use express.static(path.join(params.path, '/public'))
    app.use app.router

  app.configure 'development', ->
    app.use express.errorHandler()

  app.configure 'production', ->

initRedis = (express) ->
  RedisStore = require("connect-redis")(express)



