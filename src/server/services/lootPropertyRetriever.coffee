lootTypeRetriever = require './lootTypeRetriever'
lootStatusRetriever = require './lootStatusRetriever'
lootLevelRetriever = require './lootLevelRetriever'
q = require 'q'

getProperties = ->
  deferred = q.defer()
  lootTypeRetriever.getAll(true).then (lootTypes) ->
    lootStatusRetriever.getAll(true).then (lootStatuses) ->
      lootLevelRetriever.getAll(true).then (lootLevels) ->
        properties =
          lootTypes: lootTypes
          lootStatuses: lootStatuses
          lootLevels: lootLevels
        deferred.resolve properties
  return deferred.promise

exports = this
exports.getProperties = getProperties
