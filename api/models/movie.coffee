mongoose = require 'mongoose'

movieSchema = mongoose.Schema
  _id: mongoose.Schema.Types.ObjectId
  movieDetails: Object
  comment: Object


module.exports = mongoose.model('Movie', movieSchema)

