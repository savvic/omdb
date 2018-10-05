express = require 'express'
router = express.Router()
mongoose = require 'mongoose'
got = require 'got'

Movie = require '../models/movie'
log = console.log.bind(console)
after = (ms, fn) -> setTimeout(fn, ms)


router.get '/', (req, res, next) ->
  Movie.find()
    .exec()
    .then (docs) ->
      response = docs.map (doc) -> title: doc.movieDetails.Title
      # log response
      if docs.length >= 0 then res.render('movies', { m: response } ) else res.status(200).json({ message: 'no shit'})
    .catch (err) ->
      log err
      res.status(500).json
        error: err

module.exports = router