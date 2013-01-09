RedisStore = null
path    = require 'path'
less    = require 'less-middleware'

module.exports = (app, db, params, express) ->
  initRedis(express)
  app.configure ->
    app.set 'views', params.path + '/app/views'
    app.set 'view engine', 'jade'
    app.use express.favicon()
    app.use express.logger('dev')
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser("#{process.env.LACTOSE_COOKIEPARSER}")
    app.use express.session({ secret: "#{process.env.LACTOSE_SESSION}", store: new RedisStore(), cookie: {
      maxAge: 60000*( (60*24) * 30 ) # 30 days
    }})
    app.use less({
      src: params.path + '/app/assets/stylesheets',
      dest: params.path + '/public/stylesheets',
      prefix: '/stylesheets',
      compress: true
    })
    app.use express.static(path.join(params.path, '/public'))
    app.use app.router

  app.configure 'development', ->
    app.set 'port', process.env.PORT || 3000
    app.use express.errorHandler()

  app.configure 'production', ->
    app.set 'port', process.env.PORT || 80

initRedis = (express) ->
  RedisStore = require("connect-redis")(express)



