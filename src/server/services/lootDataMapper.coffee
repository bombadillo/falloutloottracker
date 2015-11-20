map = (raw, user) ->
  console.log raw
  data =
    lootType: raw.lootType
    lootLevel: raw.lootLevel
    description: raw.description
    location: raw.location
    lootStatus: raw.lootStatus
    user: user._id
  console.log raw
  return data

exports = this
exports.map = map
