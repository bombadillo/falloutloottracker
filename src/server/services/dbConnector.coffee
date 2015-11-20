mongoClient = require('mongodb').MongoClient
url = 'mongodb://chris:C.mum1873@ds033734.mongolab.com:33734/falloutloottracker'
q = require 'q'

connect = ->
  deferred = q.defer()
  mongoClient.connect url, (err, db) ->
    if err
      console.log 'Unable to connect'
      console.log err
    else
      console.log 'Connected'
      deferred.resolve db
  return deferred.promise

exports = this
exports.connect = connect
