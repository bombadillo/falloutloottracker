dbHandler = require './dbHandler'
q = require 'q'
lootTypeConvertor = require './lootTypeConvertor'

getAll = (bConvert, filter) ->
  deferred = q.defer()
  dbHandler.getAll('LootContainerType', filter).then (lootTypes) ->
    if bConvert
      lootTypes = lootTypeConvertor.toArray lootTypes
    deferred.resolve lootTypes
  return deferred.promise

getTypeId = (typeName) ->
  deferred = q.defer()
  if typeName
    getAll(false, name: typeName).then (lootType) ->
      deferred.resolve lootType[0]._id.toString()
  else
    deferred.resolve null
  return deferred.promise

exports = this
exports.getAll = getAll
exports.getTypeId = getTypeId
