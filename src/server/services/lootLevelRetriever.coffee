dbHandler = require './dbHandler'
q = require 'q'
lootLevelConvertor = require './lootLevelConvertor'

getAll = (bConvert, filter) ->
  deferred = q.defer()
  dbHandler.getAll('Level', filter).then (levels) ->
    if bConvert
      levels = lootLevelConvertor.toArray levels
    deferred.resolve levels
  return deferred.promise

getLevelId = (levelName) ->
  deferred = q.defer()
  if levelName
    getAll(false, name: levelName).then (lootLevel) ->
      deferred.resolve lootLevel[0]._id.toString()
  else
    deferred.resolve null
  return deferred.promise

exports = this
exports.getAll = getAll
exports.getLevelId = getLevelId
