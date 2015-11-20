toArray = (lootStatuses) ->
  aLootStatuses = []
  for status in lootStatuses
    aLootStatuses[status._id] = status.name
  return aLootStatuses

exports = this
exports.toArray = toArray
