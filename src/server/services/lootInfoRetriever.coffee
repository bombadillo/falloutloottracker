dbHandler = require './dbHandler'
q = require 'q'

getAll = (user) ->
  deferred = q.defer()
  console.log user
  dbHandler.getAll('LootContainer', user: user._id).then (loot) ->
    console.log 'got loot'
    deferred.resolve loot
  return deferred.promise

exports = this
exports.getAll = getAll
