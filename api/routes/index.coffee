express = require 'express'
router = express.Router()
mongoose = require 'mongoose'
got = require 'got'

Movie = require '../models/movie'
log = console.log.bind(console)
after = (ms, fn) -> setTimeout(fn, ms)
movieObj = {}


router.get '/', (req, res, next) ->
  res.render('index')


router.post '/', (req, res, next) ->
  title = req.body.title
  comment = req.body.comment
  if title?
    got("https://www.omdbapi.com/?t=#{ encodeURI(title) }&apikey=b71f8025", { json: true })
      .then (response) ->
        movie = new Movie
          _id: new mongoose.Types.ObjectId()
          movieDetails: response.body
          comment: ''
        movieObj = movie
        res.render('movie', { m: movie })
        Movie.find()
          .exec()
          .then (docs) ->
            thereis = true
            while thereis
              for i in docs
                if i.movieDetails.Title is movie.movieDetails.Title
                  log 'this movie is already in database'
                  thereis = true
                  return
                else
                  thereis = false
            if not thereis
              log 'this movie has been stored'
              movie.save()
              return
      .catch (err) ->
        log err
        res.status(500).json
          error: err
  if comment?
    currentTitle = movieObj.movieDetails.Title
    Movie.findOneAndUpdate()
    # Movie.find()
    #   .exec()
    #   .then (docs) ->
    #     for doc in docs
    #       if doc.movieDetails.Title is currentTitle
    #         log doc.movieDetails.Year
    #         doc.update { "comment": comment }



module.exports = router