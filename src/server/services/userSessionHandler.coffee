dbHandler = require './dbHandler'
q = require 'q'

getUserByName = (request) ->
  userName = request.cookies.vaultDweller
  deferred = q.defer()
  user = dbHandler.getOne('User', name: userName).then (user) ->
    deferred.resolve user
  return deferred.promise

isLoggedIn = (request) ->
  return request.cookies.vaultDweller

exports = this
exports.getUserByName = getUserByName
exports.isLoggedIn = isLoggedIn
