toArray = (lootLevels) ->
  aLootLevels = []
  for status in lootLevels
    aLootLevels[status._id] = status.name
  return aLootLevels

exports = this
exports.toArray = toArray
