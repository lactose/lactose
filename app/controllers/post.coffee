hl   = require 'highlight.js'
md   = require 'marked'
Post = require '../models/post'
Util = require '../helpers/utilities'


module.exports =
  default: (req, res, next, db) ->
    settings =
      title: 'Blog'
    res.render 'post/post', settings
  create: (req, res, next, db) ->
    settings =
      title: 'Create a Post'
    switch req.method.toUpperCase()
      when 'POST'
        Post.createBlogPost req.body.title, req.body.body, req.body.published, (err, item) ->
          if err
            settings.message = 'Could not create post'
          else
            settings.message = 'Successfully created post'
          res.render 'post/post', settings
      else res.render 'post/post_create', settings
  delete: (req, res, next, db) ->
    settings =
      title: 'Delete Blog Post'
    Post.deleteBlogPost req.params.id, (err, item) ->
      settings.message = "Successfully deleted post: #{item.title}"
      res.render 'post/post', settings
  view: (req, res, next, db) ->
    mdSettings =
      gfm: true,
      sanitize: true,
      highlight: (code, lang) ->
        return hl.highlight(lang, code, true).value

    md.setOptions mdSettings
    Post.findPostById req.params.id, (err, item) ->
      settings =
        title: item.title
        post: item
        md: md
        req: req
        nicedate: Util.getNiceDate item.date
      res.render 'post/post_view', settings
