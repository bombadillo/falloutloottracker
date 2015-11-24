dbHandler = require './dbHandler'
q = require 'q'

insert = (data) ->
  deferred = q.defer()
  dbHandler.insert('LootContainer', data).then (result) ->
    deferred.resolve result
  return deferred.promise

update = (data) ->
  deferred = q.defer()
  dbHandler.update('LootContainer', data).then (result) ->
    deferred.resolve result
  return deferred.promise

exports = this
exports.insert = insert
exports.update = update
