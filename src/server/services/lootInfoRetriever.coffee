dbHandler = require './dbHandler'
q = require 'q'

getAll = (filter) ->
  deferred = q.defer()
  dbHandler.getAll('LootContainer', filter).then (loot) ->
    deferred.resolve loot
  return deferred.promise

getSingle = (lootId) ->
  deferred = q.defer()
  dbHandler.getById('LootContainer', lootId).then (loot) ->
    deferred.resolve loot[0]
  return deferred.promise

exports = this
exports.getSingle = getSingle
exports.getAll = getAll
