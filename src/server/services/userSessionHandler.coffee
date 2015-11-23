dbHandler = require './dbHandler'
q = require 'q'

getUserByName = (userName) ->
  console.log "checking user #{userName}"
  deferred = q.defer()
  user = dbHandler.getOne('User', name: userName).then (user) ->
    console.log 'got user'
    deferred.resolve user
  return deferred.promise

isLoggedIn = (request) ->
  return request.cookies.vaultDweller

exports = this
exports.getUserByName = getUserByName
exports.isLoggedIn = isLoggedIn
