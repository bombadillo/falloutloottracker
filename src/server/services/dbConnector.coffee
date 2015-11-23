mongoClient = require('mongodb').MongoClient
url = 'mongodb://chris:C.mum1873@ds033734.mongolab.com:33734/falloutloottracker'
q = require 'q'

dbConnection = undefined

connect = ->
  deferred = q.defer()
  if !dbConnection
    mongoClient.connect url, (err, db) ->
      if err
        console.log 'Unable to connect'
        console.log err
      else
        console.log 'Connected'
        dbConnection = db
        deferred.resolve db
  else
    console.log 'Reusing connection'
    deferred.resolve dbConnection
  return deferred.promise

exports = this
exports.connect = connect
