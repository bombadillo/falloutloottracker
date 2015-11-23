dbHandler = require './dbHandler'
q = require 'q'
lootTypeConvertor = require './lootTypeConvertor'

getAll = (bConvert) ->
  deferred = q.defer()
  dbHandler.getAll('LootContainerType').then (lootTypes) ->
    console.log 'got loot types'
    if bConvert
      lootTypes = lootTypeConvertor.toArray lootTypes
    deferred.resolve lootTypes
  return deferred.promise

getById = (id) ->
  deferred = q.defer()
  console.log 'looking for '
  dbHandler.getOne('LootContainerType', _id: id).then(lootType) ->
    console.log 'got loot type'
    deferred.resolve lootType
  return deferred.promise

exports = this
exports.getAll = getAll
exports.getById = getById
