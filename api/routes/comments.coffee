express = require 'express'
router = express.Router()
mongoose = require 'mongoose'

Movie = require '../models/movie'
log = console.log.bind(console)

router.get '/', (req, res, next) ->
  res.status(200).json({message: "get ok"})


router.post '/', (req, res, next) ->
  res.status(200).json({message: "post ok"})


router.get '/:movieId', (req, res, next) ->
  res.status(200).json({message: "getId ok, id is #{ req.params.movieId}"})


module.exports = router