dbHandler = require './dbHandler'
q = require 'q'
lootStatusConvertor = require './lootStatusConvertor'

getAll = (bConvert, params) ->
  deferred = q.defer()
  dbHandler.getAll('Status', params).then (statuses) ->
    if bConvert
      statuses = lootStatusConvertor.toArray statuses
    deferred.resolve statuses
  return deferred.promise

getStatusId = (statusName) ->
  deferred = q.defer()
  if statusName
    getAll(false, name: statusName).then (lootStatus) ->
      deferred.resolve lootStatus[0]._id.toString()
  else
    deferred.resolve null
  return deferred.promise

exports = this
exports.getAll = getAll
exports.getStatusId = getStatusId
