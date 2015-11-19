q = require 'q'

retrieve = (db, userName) ->
  lootContainer = getLoot(db, userName)
  return lootContainer

getLoot = (db, userName) ->
  deferred = q.defer()
  collection = db.collection('lootContainer')
  collection.find(userName: userName).toArray (err, lootContainers)->
    if err
      console.log err
    else
      deferred.resolve lootContainers
    db.close()
  return deferred.promise

exports = this
exports.retrieve = retrieve
