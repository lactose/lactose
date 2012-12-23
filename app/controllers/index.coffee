module.exports =
  default: (req, res, next, db) ->
    res.render 'index', {title: 'express'}
