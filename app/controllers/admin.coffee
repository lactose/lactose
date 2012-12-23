module.exports = (req, res, next, db) ->
  default: () ->
    res.render 'admin', {title: 'admin'}
