db       = null
ObjectID = require('mongodb').ObjectID
util     = require "../helpers/utilities"

months = [ 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 
  'September', 'November', 'December' ]

init = (dbase) ->
  db = dbase
  db.post = db.collection 'post'

createBlogPost = (subject, body, publish = false, callback) ->
  today = util.getNiceDate(new Date())
  post =
    title: subject
    body: body
    public: publish
    date: today
  db.post.insert post, (err, item) ->
    console.log "successfully inserted post" unless err
    callback err, item

publishBlogPost = (id) ->
  db.post.update {_id: id}, (err, item) ->
    console.log "published post" unless err

deleteBlogPost = (id, callback) ->
  db.post.findAndModify {_id: new ObjectID(id) }, [], {remove: true},{}, (err, item) ->
    console.log "successfully deleted #{JSON.stringify(item)}" unless err
    callback err, item

findPostById = (id, callback) ->
  db.post.find {_id: new ObjectID(id) }, (err, item) ->
    console.log "found post #{JSON.stringify.item}" unless err
    callback err, item

exports.init = init
exports.createBlogPost = createBlogPost
exports.publishBlogPost = publishBlogPost
exports.deleteBlogPost = deleteBlogPost
