one = (string) ->
  return string.charAt(0).toUpperCase() + string.slice(1)

object = (obj) ->
  for item of obj
    obj[item] = one obj[item]
  return obj

exports = this
exports.one = one
exports.object = object
