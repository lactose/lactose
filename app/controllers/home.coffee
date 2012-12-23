module.exports =
  default: (req, res, next, db) ->
    res.render 'home', {title: 'express'}
