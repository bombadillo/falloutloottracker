toArray = (lootTypes) ->
  aLootTypes = []
  for type in lootTypes
    aLootTypes[type._id] = type.name
  return aLootTypes

exports = this
exports.toArray = toArray
