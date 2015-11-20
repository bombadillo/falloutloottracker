dbConnector = require './dbConnector'
BSON = require('bson').BSONPure
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
  params = params || {}
  deferred = q.defer()
  console.log "fetching one for #{collection}"
  dbConnector.connect().then (db) ->
    collection = db.collection(collection)
    console.log 'getting collection'
    console.log params
    collection.findOne params, (err, result) ->
      if err
        console.log err
      else
        deferred.resolve result
      db.close()
  return deferred.promise

getById = (collection, id) ->
  console.log id
  o_id = new BSON.ObjectID id
  deferred = q.defer()
  dbConnector.connect().then (db) ->
    collection = db.collection(collection)
    collection.find(_id: o_id).toArray (err, result)->
      if err
        console.log err
      else
        deferred.resolve result
      db.close()
  return deferred.promise

insert = (collection, data) ->
  deferred = q.defer()
  dbConnector.connect().then (db)->
    collection = db.collection collection
    collection.insert data, (err, records) ->
      if err
        console.log 'error is'
        console.log err
        deferred.resolve false
      else
        deferred.resolve true
  return deferred.promise

exports = this
exports.getAll = getAll
exports.getOne = getOne
exports.insert = insert
exports.getById = getById
