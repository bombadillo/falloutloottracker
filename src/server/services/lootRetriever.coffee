lootInfoRetriever = require '../services/lootInfoRetriever'
lootTypeRetriever = require '../services/lootTypeRetriever'
lootStatusRetriever = require '../services/lootStatusRetriever'
lootLevelRetriever = require '../services/lootLevelRetriever'
q = require 'q'

getAll = (filter) ->
  deferred = q.defer()
  lootInfoRetriever.getAll(filter).then (lootContainers) ->
    lootTypeRetriever.getAll(true).then (lootTypes) ->
      lootStatusRetriever.getAll(true).then (lootStatuses) ->
        lootLevelRetriever.getAll(true).then (lootLevels) ->
          lootObj =
            lootContainers: lootContainers
            lootTypes: lootTypes
            lootStatuses: lootStatuses
            lootLevels: lootLevels
          deferred.resolve lootObj
  return deferred.promise

getSingle = (lootId) ->
  deferred = q.defer()
  lootInfoRetriever.getSingle(lootId).then (lootContainer) ->
    lootTypeRetriever.getAll(true).then (lootTypes) ->
      lootStatusRetriever.getAll(true).then (lootStatuses) ->
        lootLevelRetriever.getAll(true).then (lootLevels) ->
          lootObj =
            lootContainer: lootContainer
            lootTypes: lootTypes
            lootStatuses: lootStatuses
            lootLevels: lootLevels
          deferred.resolve lootObj
  return deferred.promise

exports = this
exports.getAll = getAll
exports.getSingle = getSingle
