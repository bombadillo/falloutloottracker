dbHandler = require './dbHandler'
q = require 'q'
lootLevelConvertor = require './lootLevelConvertor'

getAll = (bConvert) ->
  deferred = q.defer()
  dbHandler.getAll('Level').then (levels) ->
    console.log 'got levels'
    if bConvert
      levels = lootLevelConvertor.toArray levels
    deferred.resolve levels
  return deferred.promise

exports = this
exports.getAll = getAll
