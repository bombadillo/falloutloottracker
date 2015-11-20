dbHandler = require './dbHandler'
q = require 'q'

getAll = ->
  deferred = q.defer()
  dbHandler.getAll('lootContainer').then (loot) ->
    console.log 'got loot'
    deferred.resolve loot
  return deferred.promise

exports = this
exports.getAll = getAll
