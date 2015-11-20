dbConnector = require './dbConnector'
q = require 'q'

getAll = (collection, params) ->
  params = params || {}
  deferred = q.defer()
  dbConnector.connect().then (db) ->
    collection = db.collection(collection)
    collection.find(params).toArray (err, result)->
      if err
        console.log err
      else
        deferred.resolve result
      db.close()
  return deferred.promise

getOne = (collection, params) ->

exports = this
exports.getAll = getAll
exports.getOne = getOne
