dbHandler = require './dbHandler'
q = require 'q'

register = (userName) ->
  deferred = q.defer()
  dbHandler.insert('User', name: userName).then (result) ->
    deferred.resolve result
  return deferred.promise

exports = this
exports.register = register
