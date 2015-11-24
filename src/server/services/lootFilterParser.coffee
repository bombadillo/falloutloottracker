lootTypeRetriever = require './lootTypeRetriever'
lootLevelRetriever = require './lootLevelRetriever'
lootStatusRetriever = require './lootStatusRetriever'
capitalise = require './capitalise'
q = require 'q'
objectHelper = require './objectHelper'

parse = (data) ->
  deferred = q.defer()
  data = objectHelper.clonePlainObject data
  data = objectHelper.cleanEmptyValues data
  if objectHelper.size(data) < 1
    deferred.resolve {}
  else
    data = capitalise.object data
    parseType(data).then (data) ->
      parseLevel(data).then (data) ->
        parseStatus(data).then (data) ->
          deferred.resolve data
  return deferred.promise

parseType = (data) ->
  deferred = q.defer()
  if data.lootType
    lootTypeRetriever.getTypeId(data.lootType).then (typeId) ->
      if typeId
        data.lootType = typeId
      else
        delete data.lootType
      deferred.resolve data
  else
    deferred.resolve data
  return deferred.promise

parseLevel = (data) ->
  deferred = q.defer()
  if data.lootLevel
    lootLevelRetriever.getLevelId(data.lootLevel).then (levelId) ->
      if levelId
        data.lootLevel = levelId
      else
        delete data.lootLevel
      deferred.resolve data
  else
    deferred.resolve data
  return deferred.promise

parseStatus = (data) ->
  deferred = q.defer()
  if data.lootStatus
    lootStatusRetriever.getStatusId(data.lootStatus).then (statusId) ->
      if statusId
        data.lootStatus = statusId
      else
        delete data.lootStatus
      deferred.resolve data
  else
    deferred.resolve data
  return deferred.promise

exports = this
exports.parse = parse
