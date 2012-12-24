module.exports =
  default: (req, res, next, db) ->
    db.blog.find().toArray (err, posts) ->
      res.render 'index', {title: 'lactose', posts: posts}
