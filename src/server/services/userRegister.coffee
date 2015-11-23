dbHandler = require './dbHandler'
q = require 'q'

register = (userName) ->
  deferred = q.defer()
  dbHandler.insert('User', name: userName).then (result) ->
    console.log 'register result is'
    deferred.resolve result
  return deferred.promise

exports = this
exports.register = register
