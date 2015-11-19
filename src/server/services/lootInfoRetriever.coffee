mongoClient = require('mongodb').MongoClient
url = 'mongodb://chris:C.mum1873@ds033734.mongolab.com:33734/falloutloottracker'
lootContainerRetriever = require './lootContainerRetriever'
q = require 'q'

getAll = ->
  deferred = q.defer()
  mongoClient.connect url, (err, db) ->
    if err
      console.log 'Unable to connect'
      console.log err
      defer.resolve null
    else
      console.log 'Connected'
      loot = lootContainerRetriever.retrieve(db).then (loot) ->
        console.log 'got loot'
        deferred.resolve loot
  return deferred.promise

exports = this
exports.getAll = getAll
