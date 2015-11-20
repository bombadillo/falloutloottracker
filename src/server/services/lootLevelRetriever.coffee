dbHandler = require './dbHandler'
q = require 'q'

getAll = ->
  deferred = q.defer()
  dbHandler.getAll('Level').then (levels) ->
    console.log 'got levels'
    deferred.resolve levels
  return deferred.promise

exports = this
exports.getAll = getAll
