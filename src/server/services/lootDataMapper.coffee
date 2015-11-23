map = (raw, user) ->
  data =
    _id: raw._id
    lootType: raw.lootType
    lootLevel: raw.lootLevel
    description: raw.description
    location: raw.location
    lootStatus: raw.lootStatus
    user: user._id
  return data

exports = this
exports.map = map
