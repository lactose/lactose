module.exports =
  default: (req, res, next, db) ->
    db.post.find({public: 'on'}).toArray (err, posts) ->
      dude = JSON.stringify(posts)
      res.render 'home/index', {title: 'lactose', posts: posts, dude: dude}
