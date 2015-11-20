dbHandler = require './dbHandler'
q = require 'q'
lootStatusConvertor = require './lootStatusConvertor'

getAll = (bConvert) ->
  deferred = q.defer()
  console.log 'getting sattuss'
  dbHandler.getAll('Status').then (statuses) ->
    console.log 'got statuses'
    if bConvert
      statuses = lootStatusConvertor.toArray statuses
    deferred.resolve statuses
  return deferred.promise

exports = this
exports.getAll = getAll
