db = null
init = (dbase) ->
  db = dbase
  db.blog = db.collection 'blog'

createBlogPost = (subject, body, publish = false) ->
  post =
    title: subject
    body: body
    public: publish
  db.blog.insert post, (err, item) ->
    console.log "successfully inserted post" unless err

publishBlogPost = (id) ->
  db.blog.update {_id: id}, (err, item) ->
    console.log "published post" unless err

exports.init = init
exports.createBlogPost = createBlogPost
exports.publishBlogPost = publishBlogPost
