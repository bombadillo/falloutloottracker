dbHandler = require './dbHandler'
q = require 'q'

getAll = ->
  deferred = q.defer()
  console.log 'getting sattuss'
  dbHandler.getAll('Status').then (statuses) ->
    console.log 'got statuses'
    deferred.resolve statuses
  return deferred.promise

exports = this
exports.getAll = getAll
