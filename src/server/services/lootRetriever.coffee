lootInfoRetriever = require './lootInfoRetriever'
lootPropertyRetriever = require './lootPropertyRetriever'

q = require 'q'

getAll = (filter) ->
  deferred = q.defer()
  lootInfoRetriever.getAll(filter).then (lootContainers) ->
    lootPropertyRetriever.getProperties().then (properties) ->
      lootObj = createLootObject lootContainers, properties
      deferred.resolve lootObj
  return deferred.promise

getSingle = (lootId) ->
  deferred = q.defer()
  lootInfoRetriever.getSingle(lootId).then (lootContainer) ->
    lootPropertyRetriever.getProperties().then (properties) ->
      lootObj = createLootObject lootContainer, properties
      deferred.resolve lootObj
  return deferred.promise

createLootObject = (lootContainer, properties) ->
  lootObj =
    lootContainer: lootContainer
    lootTypes: properties.lootTypes
    lootStatuses: properties.lootStatuses
    lootLevels: properties.lootLevels
  return lootObj

exports = this
exports.getAll = getAll
exports.getSingle = getSingle
