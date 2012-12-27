Post = require '../models/post'

module.exports =
  default: (req, res, next, db) ->
    res.render 'admin/admin', {title: 'admin'}
  login: (req, res, next, db) ->
    console.log "login hit"
    res.render 'admin/login', {title: 'admin'}
