dbHandler = require './dbHandler'
q = require 'q'

getUserByName = (userName) ->
  deferred = q.defer()
  user = dbHandler.getOne('User', name: userName).then (user) ->
    deferred.resolve user
  return deferred.promise

getUserFromCookie = (request) ->
  userName = request.cookies.vaultDweller
  deferred = q.defer()
  console.log 'retrieving user'
  user = dbHandler.getOne('User', name: userName).then (user) ->
    console.log 'got user'
    deferred.resolve user

  console.log 'return promise'
  return deferred.promise

isLoggedIn = (request) ->
  return request.cookies.vaultDweller

exports = this
exports.getUserByName = getUserByName
exports.getUserFromCookie = getUserFromCookie
exports.isLoggedIn = isLoggedIn
