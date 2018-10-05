express = require 'express'
app = express()
morgan = require 'morgan'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'

moviesRoutes = require './api/routes/movies'
commentsRoutes = require './api/routes/comments'
indexRoutes = require './api/routes/index'
log = console.log.bind(console)

mongoose.connect "mongodb+srv://savvic:#{ process.env.MONGO_ATLAS_PW }@clusteromdbmovies-gdmic.mongodb.net/test?retryWrites=true", useNewUrlParser: true

# set ejs as a view engine
app.set 'view engine', 'ejs'
app.use express.static(__dirname + '/public')

# log events
app.use morgan('dev')

# parse body
app.use bodyParser.urlencoded extended:false
app.use bodyParser.json()

# prevent cors errors
app.use (req, res, next) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Headers', '*'
  if req.method is 'OPTIONS'
    res.header 'Access-Control-Allow-Methods', 'POST, GET'
    res.status(200).json({})
  next()

# routes that should handle requests
app.use '/', indexRoutes
app.use '/movies', moviesRoutes
app.use '/comments', commentsRoutes

app.use (req, res, next) ->
  error = new Error 'not found'
  error.status = 404
  next(error)

app.use (err, req, res, next) ->
  res.status err.status or 500
  res.json { error: {message: err.message} }

module.exports = app