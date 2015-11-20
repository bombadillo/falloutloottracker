dbHandler = require './dbHandler'
q = require 'q'

getAll = ->
  deferred = q.defer()
  dbHandler.getAll('lootTypes').then (lootTypes) ->
    console.log 'got loot types'
    deferred.resolve lootTypes
  return deferred.promise

exports = this
exports.getAll = getAll
