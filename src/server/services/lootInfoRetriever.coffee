dbHandler = require './dbHandler'
q = require 'q'

getAll = (user) ->
  deferred = q.defer()
  console.log user
  dbHandler.getAll('LootContainer', user: user._id).then (loot) ->
    console.log 'got loot'
    deferred.resolve loot
  return deferred.promise

getSingle = (lootId) ->
  deferred = q.defer()
  dbHandler.getById('LootContainer', lootId).then (loot) ->
    console.log 'got loot'
    deferred.resolve loot[0]
  return deferred.promise

exports = this
exports.getSingle = getSingle
exports.getAll = getAll
