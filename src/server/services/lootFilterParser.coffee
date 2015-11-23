lootTypeRetriever = require './lootTypeRetriever'
lootLevelRetriever = require './lootLevelRetriever'
capitalise = require './capitalise'
q = require 'q'
objectHelper = require './objectHelper'

parse = (data) ->
  deferred = q.defer()
  data = objectHelper.cleanEmptyValues(data)
  if objectHelper.size(data) < 1
    deferred.resolve {}
  else
    data = capitalise.object data
    parseType(data).then (data) ->
      parseLevel(data).then (data) ->
        deferred.resolve data
  return deferred.promise

parseType = (data) ->
  console.log 'parsing type'
  console.log data
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
  console.log 'parsing level'
  console.log data
  deferred = q.defer()
  if data.lootLevel
    console.log 'about to call get level'
    lootLevelRetriever.getLevelId(data.lootLevel).then (levelId) ->
      console.log 'got something'
      if levelId
        data.lootLevel = levelId
      else
        delete data.lootLevel
      console.log 'got level'
      deferred.resolve data
  else
    deferred.resolve data
  return deferred.promise

exports = this
exports.parse = parse
